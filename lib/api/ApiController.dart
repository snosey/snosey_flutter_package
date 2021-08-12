import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:snosey_flutter_package/api/ApiResponse.dart';
import 'package:snosey_flutter_package/Enums.dart';

class ApiController {
  static late String baseUrl;
  static late String serverError;
  static late Map<String, String> additionalStaticParams;
  Map<RequestTypeEnum, String> requestTypeMap = {
    RequestTypeEnum.PUT: "PUT",
    RequestTypeEnum.POST: "POST",
    RequestTypeEnum.GET: "GET",
    RequestTypeEnum.DELETE: "DELETE"
  };
  final String apiUrl;
  final RequestTypeEnum requestType;
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  late http.Response response;
  late http.MultipartRequest multiPartRequest;

  ApiController(this.apiUrl, this.requestType);

  static init(
      {required String baseUrl,
      required String serverError,
      required Map<String, String> additionalStaticParams}) {
    ApiController.baseUrl = baseUrl;
    ApiController.serverError = serverError;
    ApiController.additionalStaticParams = additionalStaticParams;
  }

  Future<ApiResponse> sendRequest(
      {Map<String, dynamic>? body,
      Map<String, File>? files,
      bool isMultiPart = false,
      Map<String, String> queryParameters = const {}}) async {
    queryParameters.addAll(additionalStaticParams);

    var uri = Uri.https(baseUrl, apiUrl, queryParameters);

    log('request url: ${uri.toString()}');
    if (isMultiPart) {
      log('request body: ${body.toString()}');
      multiPartRequest =
          http.MultipartRequest(requestTypeMap[requestType]!, uri);
      multiPartRequest.headers.addAll(headers);
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
      response = await http.get(uri, headers: headers);
    } else if (requestType == RequestTypeEnum.POST) {
      log('request body: ${body.toString()}');
      response = await http.post(uri, headers: headers, body: jsonEncode(body));
    } else if (requestType == RequestTypeEnum.PUT) {
      log('request body: ${body.toString()}');
      response = await http.put(uri, headers: headers, body: jsonEncode(body));
    } else if (requestType == RequestTypeEnum.DELETE) {
      response = await http.delete(uri, headers: headers);
    }

    log('response body: ${jsonDecode(response.body)}');

    if (response.statusCode == HttpStatus.ok) {
      var apiResponse = ApiResponse();
      apiResponse.setStatus(jsonDecode(response.headers["x-status"]!));
      if (response.headers.containsKey("x-pagination")) {
        apiResponse.pagination.hasPagination = true;
        apiResponse.pagination
            .init(jsonDecode(response.headers["x-pagination"]!));
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
      throw serverError;
    }
  }

  _fillMultiPart(String key, dynamic value, String root) {
    /*
          if (params.get(key) is JSONObject || params.get(key) is JSONArray) {
            fileParams.addPart(key, StringBody(params.get(key).toString(), ContentType.TEXT_PLAIN.withCharset("UTF-8")))
          } else {
            fileParams.addTextBody(key, params.get(key).toString(), ContentType.TEXT_PLAIN.withCharset("UTF-8"))
          }*/
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
