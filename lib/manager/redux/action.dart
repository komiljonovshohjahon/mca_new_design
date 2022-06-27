import 'package:dio/dio.dart' as DIO;
import 'package:mca_new_design/template/base/template.dart';

//------------------------ API Action ---------------------------

class GetRunApiFetchAction {
  String invokeMethod;
  dynamic params;
  dynamic data;
  bool showErrorPopup;
  bool closeLoadingOnError;
  ReqType reqType;
  String? contentType;

  GetRunApiFetchAction(this.invokeMethod,
      {this.params,
      this.data,
      this.reqType = ReqType.POST,
      this.contentType,
      this.showErrorPopup = true,
      this.closeLoadingOnError = false});
}

//------------------------ Hive Action ---------------------------

class GetExportHiveAction {
  String key;
  dynamic value;
  GetExportHiveAction({required this.key, required this.value});
}

class GetImportHiveAction {
  String key;
  GetImportHiveAction({required this.key});
}

class GetDeleteHiveAction {
  String key;
  GetDeleteHiveAction({required this.key});
}

//------------------------ Login Action ---------------------------

class GetTokenAction {
  String domain;
  String username;
  String pwd;

  GetTokenAction(
      {required this.username, required this.domain, required this.pwd});
}

class GetResetAction {
  final bool removeTest;
  final bool removeError;
  final bool removeReg;
  final bool removeLocAccess;
  GetResetAction(
      {this.removeTest = true,
      this.removeError = true,
      this.removeReg = true,
      this.removeLocAccess = false});
}

class GetEnableTestModeAction {}

class GetRenewAccessTokenAction {
  DIO.RequestOptions? reqOpt;
  GetRenewAccessTokenAction({this.reqOpt});
}
