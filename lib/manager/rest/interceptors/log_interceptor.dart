import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

JsonEncoder encoder = const JsonEncoder.withIndent('  ');

final loggerInterceptor =
    InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });

  Logger.d(
      "| [DIO] Request: ${(options.method)} - ${(options.baseUrl)} -  ${(options.path)}");
  // if (options.data != null) Logger.d("| ${(options.data.toString())}");
  if (options.queryParameters.isNotEmpty) {
    Logger.d("| Request_Options: ${options.queryParameters}");
  }
  if (options.data != null) Logger.d("| Request_Data: ${options.data}");
  Logger.d("| Headers: $headers");

  handler.next(options); //continue
}, onResponse: (Response response, handler) async {
  Logger.i(
      "| [DIO] Response [path -> ${(response.requestOptions.path)}] ||| [method -> ${(response.requestOptions.method)}] ||| [code -> ${(response.statusCode)}]:${(response.data.toString())}");

  handler.next(response);
  // return response; // continue
}, onError: (DioError error, handler) async {
  Logger.e(
      "| [DIO] Error [path -> ${(error.requestOptions.path)}] ||| [method -> ${(error.requestOptions.method)}] ||| [code -> ${(error.response?.statusCode)}]:${(error.response?.data.toString())}");

  handler.next(error); //continue
});
