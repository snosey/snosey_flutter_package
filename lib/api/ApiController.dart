import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snosey_flutter_package/Enums.dart';
import 'package:snosey_flutter_package/api/ApiResponse.dart';

class ApiController {
  static late String baseUrl;
  static late String appSecret;
  static late String apiKey;
  static late String userAgent;
  static late String serverErrorMessage;
  static late String refreshTokenUrl;
  static Map<String, String> staticParams = {};
  static String _cookies = "";
  Map<RequestTypeEnum, String> requestTypeMap = {
    RequestTypeEnum.PUT: "PUT",
    RequestTypeEnum.POST: "POST",
    RequestTypeEnum.GET: "GET",
    RequestTypeEnum.DELETE: "DELETE"
  };
  final String apiUrl;
  final RequestTypeEnum requestType;
  static Map<String, String> staticHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  late http.Response response;
  late http.MultipartRequest multiPartRequest;

  ApiController(this.apiUrl, this.requestType);

  static init({
    required String baseUrl,
    required String serverErrorMessage,
    required String appSecret,
    required UserAgentEnum userAgent,
    required String apiKey,
    required String refreshTokenUrl,
  }) {
    ApiController.baseUrl = baseUrl;
    ApiController.refreshTokenUrl = refreshTokenUrl;
    ApiController.serverErrorMessage = serverErrorMessage;
    _addCookies("Secret", appSecret);
    _addCookies("Api-Key", apiKey);
    staticHeaders["User-Agent"] =
        userAgent.toString().replaceFirst("UserAgentEnum.", "");
  }

  static _addCookies(String key, String value) {
    _cookies += "$key=$value;";
  }

  Future<ApiResponse> sendRequest(
      {Map<String, dynamic>? body,
      Map<String, File>? files,
      bool isMultiPart = false,
      Map<String, String> header = const {},
      Map<String, String> queryParameters = const {}}) async {
    staticParams.addAll(queryParameters);
    staticHeaders["Cookie"] = _cookies;
    staticHeaders.addAll(header);
    var uri = Uri.https(baseUrl, apiUrl, staticParams);
    log('request url: ${uri.toString()}');
    log('request header: ${staticHeaders.toString()}');
    if (isMultiPart) {
      log('request body: ${body.toString()}');
      multiPartRequest =
          http.MultipartRequest(requestTypeMap[requestType]!, uri);
      multiPartRequest.headers.addAll(staticHeaders);
      if (files != null && files.isNotEmpty) {
        files.forEach((name, file) {
          multiPartRequest.files.add(http.MultipartFile(
              name, file.readAsBytes().asStream(), file.lengthSync(),
              filename: name));
        });
      }
      if (body != null && body.isNotEmpty)
        body.forEach((key, value) {
          _fillMultiPart(key, value, "");
        });

      log('multipart body: ${multiPartRequest.fields.toString()}');
      var streamResponse = await multiPartRequest.send();
      response = await http.Response.fromStream(streamResponse);
    } else if (requestType == RequestTypeEnum.GET) {
      response = await http.get(uri, headers: staticHeaders);
    } else if (requestType == RequestTypeEnum.POST) {
      log('request body: ${body.toString()}');
      response =
          await http.post(uri, headers: staticHeaders, body: jsonEncode(body));
    } else if (requestType == RequestTypeEnum.PUT) {
      log('request body: ${body.toString()}');
      response =
          await http.put(uri, headers: staticHeaders, body: jsonEncode(body));
    } else if (requestType == RequestTypeEnum.DELETE) {
      response = await http.delete(uri, headers: staticHeaders);
    }

    log('response body: ${jsonDecode(response.body)}');

    if (response.statusCode == HttpStatus.ok) {
      if (response.headers.containsKey("authorization")) {
        Auth._setBearerToken(
            token: response.headers["authorization"]!,
            expiration: response.headers["expires"]!);
        Auth._setRefreshToken(response.headers["set-cookie"]!);
      }

      var apiResponse = ApiResponse();
      apiResponse.setStatus(jsonDecode(response.headers["x-status"]!));
      if (response.headers.containsKey("x-pagination")) {
        apiResponse.pagination.hasPagination = true;
        apiResponse.pagination
            .set(jsonDecode(response.headers["x-pagination"]!));
      } else {
        apiResponse.pagination.hasPagination = false;
      }
      log('response status: ${response.headers["x-status"]}');
      if (apiResponse.success) {
        apiResponse.objectResponse = jsonDecode(response.body);
        return apiResponse;
      } else
        throw utf8.decode(base64.decode(apiResponse.errorMessage));
    } else {
      throw serverErrorMessage;
    }
  }

  _fillMultiPart(String key, dynamic value, String root) {
    if (value is Map) {
      value.forEach((key2, value2) {
        _fillMultiPart(key2, value2, key + ".");
      });
    } else if (value is List) {
      for (int i = 0; i < value.length; i++)
        _fillMultiPart("$key[$i]'", value[i], root);
    } else {
      multiPartRequest.fields[root + key] = value.toString();
    }
  }
}

class Auth {
  static var expirationFormat = DateFormat("E, dd MMM yyy HH:mm:ss 'GMT'");
  static Timer? reNewExpirationTimer;

  static _setBearerToken({
    required String token,
    required String expiration,
  }) {
    ApiController.staticHeaders["Authorization"] = token;
    var expirationMin = DateTime.now()
            .difference(expirationFormat.parse(expiration))
            .inMinutes -
        5;
    print("renew in $expirationMin min");
    reNewExpirationTimer = Timer(Duration(minutes: expirationMin), () {
      reNewToken();
    });
  }

  static Future<bool> reNewToken() async {
    final storage = new FlutterSecureStorage();
    String? expires = await storage.read(key: "expires");
    if (expires != null &&
        expirationFormat.parse(expires).isAfter(DateTime.now())) {
      String? token = await storage.read(key: "refreshToken");
      var response = await ApiController(
              ApiController.refreshTokenUrl, RequestTypeEnum.POST)
          .sendRequest(body: {"Token": token!});
      return response.success;
    } else {
      return false;
    }
  }

  static clearToken() {
    if (reNewExpirationTimer != null) reNewExpirationTimer!.cancel();
    if (ApiController.staticHeaders.containsKey("Authorization"))
      ApiController.staticHeaders.remove("Authorization");
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
  }

  static _setRefreshToken(String cookies) {
    final storage = new FlutterSecureStorage();
    cookies.split(";").forEach((element) {
      var key = element.split("=").first;
      var value = element.split("=").last;
      if (key == "refreshToken" || key == "expires") {
        storage.write(key: key, value: value);
      }
    });
  }
}
