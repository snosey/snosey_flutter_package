import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as storageSecure;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dinnova/DinnovaEnums.dart';
import 'package:dinnova/api/DinnovaApiResponse.dart';

class DinnovaApiController {
  static late String baseUrl;
  static String? appSecret;
  static String? apiKey;
  static String? userAgent;
  static String? authorization;
  static String? authorizationExpired;
  static late String serverErrorMessage;
  static String? refreshTokenUrl;
  static String? revokeTokenUrl;
  static Map<String, String> staticParams = {};
  static String _cookies = "";
  final String apiUrl;
  final DinnovaRequestTypeEnum requestType;
  static Map<String, String> staticHeaders = {};
  static ByteData? _pemCer;
  static ByteData? _keyCer;
  static String? _secretCer;
  Map<DinnovaRequestTypeEnum, String> requestTypeMap = {
    DinnovaRequestTypeEnum.PUT: "PUT",
    DinnovaRequestTypeEnum.POST: "POST",
    DinnovaRequestTypeEnum.GET: "GET",
    DinnovaRequestTypeEnum.DELETE: "DELETE"
  };

  DinnovaApiController(this.apiUrl, this.requestType);

  static init({
    required String baseUrl,
    required String serverErrorMessage,
  }) {
    DinnovaApiController.baseUrl = baseUrl;
    DinnovaApiController.serverErrorMessage = serverErrorMessage;
  }

/*  static _addCookies(String key, String value) {
    _cookies += "$key=$value;";
  }*/

  Future<DinnovaApiResponse> sendRequest({
    Map<String, dynamic> body = const {},
    List<Map<String, dynamic>>? listBody,
    Map<String, PlatformFile> files = const {},
    bool isMultiPart = false,
    Map<String, String> header = const {},
    Map<String, String> queryParameters = const {},
    String? optionalUrl,
  }) async {
    Map<String, String> finalQueryParams = {};
    finalQueryParams.addAll(queryParameters);
    finalQueryParams.addAll(staticParams);

    if (_cookies.isNotEmpty) staticHeaders["Cookie"] = _cookies;
    staticHeaders.addAll(header);
    var requestData;
    if (isMultiPart) {
      requestData = FormData();
      if (files.isNotEmpty) {
        requestData.files.addAll(files.map((fileKey, file) {
          var fileName = file.name;
          var contentType = MediaType("image", file.name.split(".")[1]);
          return MapEntry(
              fileKey,
              MultipartFile.fromBytes(
                file.bytes!,
                filename: fileName,
                contentType: contentType,
              ));
        }).entries);
      }
      if (listBody != null) {
        listBody.forEach((element) {
          element.forEach((key, value) {
            requestData.fields.add(fillMultiPart(key, value, "")!);
          });
        });
      } else {
        if (body.isNotEmpty) {
          body.forEach((key, value) {
            requestData.fields.add(fillMultiPart(key, value, "")!);
          });
        }
      }
    } else {
      requestData = listBody ?? body;
    }
    var api = Dio(
      BaseOptions(
        baseUrl: optionalUrl ?? baseUrl,
        contentType: 'application/json; charset=UTF-8',
        responseType: ResponseType.json,
        headers: staticHeaders,
        extra: {
          "withCredentials": true,
        },
        method: requestType.toString().replaceAll("DinnovaRequestTypeEnum.", ""),
      ),
    );

    if (_pemCer != null) {
      if (!kIsWeb) {
        (api.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
          SecurityContext serverContext = new SecurityContext()
            ..useCertificateChainBytes(_pemCer!.buffer.asUint8List())
            ..usePrivateKeyBytes(_keyCer!.buffer.asUint8List(),
                password: _secretCer!);

          HttpClient httpClient = HttpClient(
            context: serverContext,
          );

          httpClient.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

          return httpClient;
        };
      }
    }

    api.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    var response = await api
        .request(
          apiUrl,
          data: requestData,
          options: Options(
            extra: {
              "withCredentials": true,
            },
          ),
          queryParameters: finalQueryParams,
        )
        .onError((error, stackTrace) => throw serverErrorMessage);
    if (response.statusCode == HttpStatus.ok) {
      var commaDecode = "\\002C";
      if (response.headers.value("authorization") != null) {
        Auth._setBearerToken(
          token: response.headers
              .value("authorization")!
              .replaceAll(commaDecode, ","),
          expiration:
              response.headers.value("expires")!.replaceAll(commaDecode, ","),
        );
        await Auth._setRefreshToken(response.headers
            .value("Set-Refresh")!
            .replaceAll(commaDecode, ","));
      }

      var apiResponse = DinnovaApiResponse();
      apiResponse.setStatus(jsonDecode(
          response.headers.value("x-status")!.replaceAll(commaDecode, ",")));
      if (response.headers.value("x-pagination") != null) {
        apiResponse.pagination.hasPagination = true;
        apiResponse.pagination.set(jsonDecode(response.headers
            .value("x-pagination")!
            .replaceAll(commaDecode, ",")));
      } else {
        apiResponse.pagination.hasPagination = false;
      }
      if (apiResponse.success) {
        apiResponse.objectResponse = response.data;
        return apiResponse;
      } else
        throw utf8.decode(base64.decode(apiResponse.errorMessage));
    } else {
      throw serverErrorMessage;
    }
  }

  MapEntry<String, String>? fillMultiPart(
      String key, dynamic value, String root) {
    if (value is Map) {
      for (var object in value.entries) {
        return fillMultiPart(object.key, object.value, root + key + ".");
      }
    } else if (value is List) {
      for (int i = 0; i < value.length; i++)
        return fillMultiPart("$key[$i]", value[i], root);
    } else {
      return MapEntry("$root$key", value.toString());
    }
  }
}

class Auth {
  static var _expirationFormat = DateFormat("E, dd MMM yyy HH:mm:ss 'GMT'");
  static Timer? _reNewExpirationTimer;

  static init({
    required String appSecret,
    required DinnovaUserAgentEnum userAgent,
    required String apiKey,
    required String refreshTokenUrl,
    required String revokeTokenUrl,
    ByteData? pemCer,
    ByteData? keyCer,
    required String? secretCer,
  }) {
    DinnovaApiController.refreshTokenUrl = refreshTokenUrl;
    DinnovaApiController.revokeTokenUrl = revokeTokenUrl;
    DinnovaApiController.staticHeaders["Secret"] = appSecret;
    DinnovaApiController.staticHeaders["Api-Key"] = apiKey;
    DinnovaApiController.staticHeaders["User-Platform"] =
        userAgent.toString().replaceFirst("UserAgentEnum.", "");
    DinnovaApiController._pemCer = pemCer;
    DinnovaApiController._keyCer = keyCer;
    DinnovaApiController._secretCer = secretCer;
  }

  static _setBearerToken({
    required String token,
    required String expiration,
  }) {
    DinnovaApiController.authorization = token;
    DinnovaApiController.authorizationExpired = expiration;
    DinnovaApiController.staticHeaders["Authorization-Token"] = token;
    var expirationMin = DateTime.now()
            .difference(_expirationFormat.parse(expiration))
            .inMinutes -
        5;
    print("renew in $expirationMin min");
    _reNewExpirationTimer = Timer(Duration(minutes: expirationMin), () {
      reNewToken();
    });
  }

  static Future<bool> reNewToken() async {
    String? expires;
    String? token;
    if (!kIsWeb) {
      final storage = new storageSecure.FlutterSecureStorage();
      expires = await storage.read(key: "Expires");
      token = await storage.read(key: "RefreshToken");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      expires = prefs.getString("Expires");
      token = prefs.getString("RefreshToken");
    }
    if (expires != null &&
        _expirationFormat.parse(expires).isAfter(DateTime.now())) {
      bool isAuth = false;

      await DinnovaApiController(
              DinnovaApiController.refreshTokenUrl!, DinnovaRequestTypeEnum.POST)
          .sendRequest(body: {"Token": token!}).then((value) {
        isAuth = true;
      }).onError((error, stackTrace) {
        isAuth = false;
      });
      return isAuth;
    } else {
      return false;
    }
  }

  static Future<bool> clearToken() async {
    String? token;
    if (!kIsWeb) {
      final storage = new storageSecure.FlutterSecureStorage();
      token = await storage.read(key: "RefreshToken");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString("RefreshToken");
    }

    bool isCleared = false;

    await DinnovaApiController(
            DinnovaApiController.revokeTokenUrl!, DinnovaRequestTypeEnum.POST)
        .sendRequest(body: {"Token": token!}).then((value) {
      isCleared = true;
      if (_reNewExpirationTimer != null) _reNewExpirationTimer!.cancel();
      if (DinnovaApiController.staticHeaders.containsKey("Authorization-Token"))
        DinnovaApiController.staticHeaders.remove("Authorization-Token");

      if (!kIsWeb) {
        final storage = new storageSecure.FlutterSecureStorage();
        storage.deleteAll();
      } else {
        SharedPreferences.getInstance().then((value) => value.clear());
      }
    }).onError((error, stackTrace) {
      isCleared = false;
    });
    return isCleared;
  }

  static _setRefreshToken(String refreshToken) async {
    final storage = new storageSecure.FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> json = jsonDecode(refreshToken);
    json.forEach((key, value) {
      if (!kIsWeb)
        storage.write(key: key, value: value);
      else
        prefs.setString(key, value);
    });
  }
/*
  static _setRefreshToken2(String cookies) async {
    final storage = new storageSecure.FlutterSecureStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cookies.split("; ").forEach((element) {
      var key = element.split("=").first;
      var value = element.split("=").last;
      if (key == "refreshToken" || key == "expires") {
        if (!kIsWeb)
          storage.write(key: key, value: value);
        else {
          prefs.setString(key, value);
        }
      }
    });
  }*/
}
