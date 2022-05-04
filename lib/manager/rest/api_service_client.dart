import 'package:dio/adapter.dart';
import "package:dio/dio.dart";
import 'package:mca_new_design/template/base/template.dart';
import 'dart:io';
import 'dart:io' as IO;
import 'interceptors/log_interceptor.dart';

class ApiClient {
  final String? token;
  final String? contentType;
  final Map<String, dynamic>? queryParameters;
  final String baseUrl;

  ApiClient(
      {this.token,
      this.queryParameters,
      this.contentType,
      required this.baseUrl});

  Map<String, dynamic>? get headers {
    if (token != null) {
      return {
        "Authorization": "Bearer $token",
        "Content-Type": contentType ?? "application/json",
        "Accept": "application/json",
        "Accept-Encoding": 'gzip,compress'
      };
    }
    return {
      "Content-Type": contentType ?? "application/json",
      "Accept": "application/json",
      "Accept-Encoding": "gzip,compress"
    };
  }

  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(loggerInterceptor);
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        queryParameters: queryParameters);
    _dio.options = options;
    return _dio;
  }
}

class ApiInvokes {
  static const String invokeToken = "/oauth/v2/token";
  static const String invokePing = "/api/ping";
  static const String invokeRegister = "/api/register";
  static const String invokeDetails = '/api/details';
  static const String invokeLocation = '/api/location';
  static const String invokeAvailable = '/api/available';
  static const String invokeShifts = '/api/shifts';
  static const String invokePhoto = '/api/photo';
  static const String invokeCompany = '/api/company';
  static const String invokeCurrentStatus = '/api/currentstatus';
  static const String invokeTimesheet = '/api/timesheet';
  static const String invokeChecklist = '/api/checklist';
  static const String invokeRelease = '/api/release';
  static const String invokeMessages = '/api/messages';
  static const String invokeRequestType = '/api/requesttype';
  static const String invokeHoliday = '/api/holiday';
  static const String invokeUnavailable = '/api/unavailable';
  static const String invokeMobileAdmin = '/api/mobileadmin';
  static const String invokeProgress = '/api/progress';
  static const String invokeCurrentStock = '/api/currentstock';
  static const String invokeStorage = '/api/storage';
  static const String invokeInformations = '/api/informations';
  static const String invokeCurrentShifts = '/api/currentshifts';
  static const String invokeCompletedShifts = '/api/completedshifts';
  static const String invokeNextShifts = '/api/nextshifts';
}
