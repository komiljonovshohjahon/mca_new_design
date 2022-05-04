import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:mca_new_design/manager/rest/api_service_client.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:redux/redux.dart';

import '../../periodic_actions.dart';

class LoginMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    // ALWAYS GO BY ORDER switch case -> top to bottom
    //                      functions -> top to bottom
    switch (action.runtimeType) {
      case GetTokenAction:
        return _getTokenAction(store.state, action, next);
      case GetRenewAccessTokenAction:
        return _getRenewAccessTokenAction(store.state, action, next);
      case GetResetAction:
        return _getResetAction(store.state, action, next);
      case GetEnableTestModeAction:
        return _getEnableTestModeAction(store.state, action, next);
      case GetChangeLocaleAction:
        return _getChangeLocaleAction(store.state, action, next);
      default:
        return next(action);
    }
  }

///////////////////////DO NOT DECLARE FUNCTIONS BEFORE THIS LINE//////////////////////////

  _getTokenAction(
      AppState state, GetTokenAction action, NextDispatcher next) async {
    showLoadingDialog();
    final username = action.username;
    final pwd = action.pwd;
    final domain = action.domain;
    final String? deviceId = await _getDeviceIdAction();
    final DIO.Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeToken,
        reqType: ReqType.POST,
        showErrorPopup: false,
        data: {
          "grant_type": Constants.grantType,
          "username": username,
          "password": pwd,
          "device_id": deviceId,
          "domain": domain,
          "client_id": Constants.clientId,
          "client_secret": Constants.clientSecret
        }));
    if (res != null) {
      next(UpdateInitAction(
          apiError: ApiError(error: null, error_description: null)));
      await appStore.dispatch(
          GetExportHiveAction(value: res.data, key: Constants.hiveTokenKey));
      await appStore.dispatch(
          GetRunApiFetchAction(ApiInvokes.invokePing, reqType: ReqType.POST));
      //Success
      final DIO.Response? regRes = await appStore.dispatch(GetRunApiFetchAction(
          ApiInvokes.invokeRegister,
          reqType: ReqType.POST,
          showErrorPopup: false,
          data: {
            "device_id": deviceId,
            "locale": Get.deviceLocale?.languageCode
          }));
      if (regRes != null) {
        //Success
        await appStore.dispatch(
            GetExportHiveAction(value: true, key: Constants.hiveRegKey));
        await appStore.dispatch(GetModelsInitAction(successAction: () {
          next(UpdateInitAction(
              apiError: ApiError(error: null, error_description: null)));
          appStore.replace(AppRoutes.RouteToMain);
        }));
      } else {
        //Fail
      }
    } else {
      // appStore.popupPop();
      //Fail
    }
  }

  _getResetAction(
      AppState state, GetResetAction action, NextDispatcher next) async {
    showLoadingDialog();
    next(UpdateInitAction(
        apiError: ApiError(error: null, error_description: null)));
    final DIO.Response? res = await appStore.dispatch(
        GetRunApiFetchAction(ApiInvokes.invokePing, reqType: ReqType.POST));
    if (res != null) {
      final DIO.Response? resRegisterDel = await appStore.dispatch(
          GetRunApiFetchAction(ApiInvokes.invokeRegister,
              reqType: ReqType.DELETE));
      // if (res != null) {
      //Success
    }
    next(UpdateInitAction(isReset: true));
    await appStore.dispatch(GetDeleteHiveAction(key: Constants.hiveTokenKey));
    await appStore.dispatch(GetDeleteHiveAction(key: Constants.hiveTestKey));
    await appStore.dispatch(GetDeleteHiveAction(key: Constants.hiveRegKey));
    await appStore.replace(AppRoutes.RouteToSignUp);
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // } else {
    //   next(UpdateInitAction(isReset: true));
    //   await appStore.dispatch(GetDeleteHiveAction(key: Constants.hiveTokenKey));
    //   await appStore.dispatch(GetDeleteHiveAction(key: Constants.hiveTestKey));
    //   await appStore.pushAndRemoveUntil(AppRoutes.RouteToSignUp);
    //   //Fail
    //   appStore.popupPop();
    // }
  }

  Future _getRenewAccessTokenAction(AppState state,
      GetRenewAccessTokenAction action, NextDispatcher next) async {
    String refreshToken = state.initState.refresh_token;
    // showLoadingDialog();
    final String? deviceId = await _getDeviceIdAction();
    dynamic res;
    try {
      res = await ApiClient(
              baseUrl: state.initState.isTest
                  ? Constants.restBaseUrlDev
                  : Constants.restBaseUrlProd)
          .init()
          .request(ApiInvokes.invokeToken,
              data: {
                "grant_type": 'refresh_token',
                "refresh_token": refreshToken,
                "client_id": Constants.clientId,
                "device_id": deviceId,
                "client_secret": Constants.clientSecret
              },
              options: DIO.Options(method: ReqType.POST.toStr()));
    } on DIO.DioError catch (e) {
      logger(e.response, hint: 'GetRenewAccessTokenAction');
      showResMessageEvent(e.response);
      res = null;
    }
    if (res != null) {
      // Success
      await appStore.dispatch(
          GetExportHiveAction(value: res.data, key: Constants.hiveTokenKey));
      if (action.reqOpt != null) {
        try {
          // showLoadingDialog();
          final result = await ApiClient(
                  baseUrl: state.initState.isTest
                      ? Constants.restBaseUrlDev
                      : Constants.restBaseUrlProd,
                  token: res.data['access_token'])
              .init()
              .request(action.reqOpt!.path,
                  queryParameters: action.reqOpt!.queryParameters,
                  data: action.reqOpt!.data,
                  options: DIO.Options(method: action.reqOpt!.method));
          // closeLoading();
          return result;
        } on DIO.DioError catch (e) {
          // closeLoading();
        }
      }
    } else {
      _getResetAction(state, GetResetAction(), next);
      appStore.replace(AppRoutes.RouteToSignUp);
    }
    return res;
  }
}

Future<String?> _getDeviceIdAction() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.androidId;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  }
  return null;
}

_getEnableTestModeAction(
    AppState state, GetEnableTestModeAction action, NextDispatcher next) async {
  final bool isTest = state.initState.isTest;
  await appStore.dispatch(
      GetExportHiveAction(value: !isTest, key: Constants.hiveTestKey));
  next(UpdateInitAction(
      apiError: ApiError(error: null, error_description: null)));
  await appStore.replace(AppRoutes.RouteToSignUp);
}

Future _getChangeLocaleAction(
    AppState state, GetChangeLocaleAction action, NextDispatcher next) async {
  String? locale = await appStore
      .dispatch(GetImportHiveAction(key: Constants.hiveLocaleKey));
  locale = locale ??
      (Get.deviceLocale != null ? Get.deviceLocale!.languageCode : 'en');
  if (action.locale == null) {
    switch (locale) {
      case "en":
        await Get.updateLocale(Locales().EnLocale);
        break;
      case "pt":
        await Get.updateLocale(Locales().PtLocale);
        break;
      case "hu":
        await Get.updateLocale(Locales().HuLocale);
        break;
    }
  } else {
    switch (action.locale) {
      case "en":
        await Get.updateLocale(Locales().EnLocale);
        break;
      case "pt":
        await Get.updateLocale(Locales().PtLocale);
        break;
      case "hu":
        await Get.updateLocale(Locales().HuLocale);
        break;
    }
  }
}

///////////////////////DO NOT DECLARE FUNCTIONS AFTER THIS LINE//////////////////////////
