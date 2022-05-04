import 'package:dio/dio.dart' as DIO;
import 'package:mca_new_design/manager/rest/api_service_client.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:redux/redux.dart';

import '../states/init_state.dart';

class ApiMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    // ALWAYS GO BY ORDER switch case -> top to bottom
    //                      functions -> top to bottom
    switch (action.runtimeType) {
      case GetRunApiFetchAction:
        return _getRunApiFetchAction(store.state, action, next);
      default:
        return next(action);
    }
  }
}
///////////////////////DO NOT DECLARE FUNCTIONS BEFORE THIS LINE//////////////////////////

Future _getRunApiFetchAction(
    AppState state, GetRunApiFetchAction action, NextDispatcher next) async {
  final bool _isTest = state.initState.isTest;
  String _baseUrl = Constants.restBaseUrlDev;
  if (!_isTest) {
    _baseUrl = Constants.restBaseUrlProd;
  }
  final _fetchRes = await _fetch(
      action.invokeMethod, action.params, action.data, action.reqType,
      baseUrl: _baseUrl,
      token: state.initState.access_token,
      showErrorPopup: action.showErrorPopup,
      contentType: action.contentType,
      closeLoadingOnError: action.closeLoadingOnError);
  return _fetchRes;
}

///////////////////////DO NOT WRITE CODE AFTER THIS LINE//////////////////////////

Future showLoadingDialog({bool barrierDismissible = false}) {
  return showSimpleDialog(
      paddingBottom: 10,
      paddingTop: 10,
      barrierDismissible: barrierDismissible,
      horizontalPadding: 10,
      body: Container(
          color: Colors.white,
          width: 200.w,
          height: 100.h,
          child: Center(
              child: SpacedColumn(
            verticalSpace: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedText(
                  text: 'please_wait_loading',
                  textStyle: ThemeTextSemibold.lg
                      .apply(color: Colors.black.withOpacity(0.7))),
            ],
          ))));
}

//
closeLoading() => appStore.popupPop();

//
Future<void> alert(String message, [String? title]) {
  return showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: SizedText(text: title ?? 'information'.tr),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text('close'.tr),
          ),
        ],
      );
    },
  );
}

showResMessageEvent(res, {bool showErrorPopup = true}) {
  //Result
  // if (Constants.isDebugMode) {
  //   alert(res.toString());
  // }
  if (showErrorPopup) {
    alert(res.toString());
  }
}

Future _fetch(
    String invokeMethod, dynamic params, dynamic data, ReqType reqType,
    {String? token,
    required String baseUrl,
    required bool showErrorPopup,
    required bool closeLoadingOnError,
    String? contentType}) async {
  // showLoadingDialog();
  final DIO.RequestOptions reqOpt = DIO.RequestOptions(
      path: invokeMethod,
      method: reqType.toStr(),
      data: data,
      queryParameters: params);

  try {
    final res = await ApiClient(
            token: token,
            contentType: contentType,
            queryParameters: params,
            baseUrl: baseUrl)
        .init()
        .request(reqOpt.path,
            queryParameters: reqOpt.queryParameters,
            data: reqOpt.data,
            options: DIO.Options(method: reqOpt.method));
    // closeLoading();
    return res;
  } on DIO.DioError catch (e) {
    appStore.isLoading(false);
    logger(e.response, hint: 'API_ERROR_$invokeMethod');
    if (e.response != null) {
      //register related errors start
      if (invokeMethod == ApiInvokes.invokeRegister ||
          invokeMethod == ApiInvokes.invokeToken) {
        closeLoading();
        appStore.dispatch(UpdateInitAction(
            apiError: ApiError(
                error: null, error_description: e.response.toString())));
        if (e.response!.data is Map &&
            e.response!.data.containsKey("error_description")) {
          appStore.dispatch(
              UpdateInitAction(apiError: ApiError.fromJson(e.response!.data)));
        }
      }
      //register related errors end

      int? statusCode = e.response!.statusCode;
      if (statusCode != null) {
        switch (statusCode) {
          case 401:
            if (e.requestOptions.path != ApiInvokes.invokePing) {
              logger(true, hint: 'TOKEN_EXPIRED');
              // _showResMessageEvent(e.response);
              return await appStore
                  .dispatch(GetRenewAccessTokenAction(reqOpt: reqOpt));
            }
            break;
          default:
            if (closeLoadingOnError) {
              closeLoading();
            }
            if (showErrorPopup) {
              showResMessageEvent(e.response);
            }
        }
      }
    }
  }
  // DIO.Response<dynamic> res;
  // showLoadingDialog();
  // switch (reqType) {
  //   case ReqType.POST:
  //     try {
  //       res = await _getClient(tokenAuth: token)
  //           .post(invokeMethod, data: data, queryParameters: params);
  //     } on DIO.DioError catch (e) {
  //       closeLoading();
  //       logger(e.response);
  //       _showResMessageEvent(e.response);
  //       return null;
  //     }
  //     break;
  //   case ReqType.GET:
  //     try {
  //       res = await _getClient(tokenAuth: token, queryParameters: params)
  //           .get(invokeMethod);
  //       logger(jsonEncode(res.data), hint: 'RESSSS');
  //       break;
  //     } on DIO.DioError catch (e) {
  //       closeLoading();
  //       logger(e.response);
  //       _showResMessageEvent(e.response);
  //       return null;
  //     }
  //   case ReqType.PUT:
  //     try {
  //       res = await _getClient(tokenAuth: token)
  //           .put(invokeMethod, data: data, queryParameters: params);
  //       break;
  //     } on DIO.DioError catch (e) {
  //       closeLoading();
  //       logger(e.response);
  //       _showResMessageEvent(e.response);
  //       return null;
  //     }
  //   case ReqType.PATCH:
  //     try {
  //       res = await _getClient(tokenAuth: token)
  //           .patch(invokeMethod, data: data, queryParameters: params);
  //       break;
  //     } on DIO.DioError catch (e) {
  //       closeLoading();
  //       logger(e.response);
  //       _showResMessageEvent(e.response);
  //       return null;
  //     }
  //   case ReqType.DELETE:
  //     try {
  //       res = await _getClient(tokenAuth: token)
  //           .delete(invokeMethod, data: data, queryParameters: params);
  //       break;
  //     } on DIO.DioError catch (e) {
  //       closeLoading();
  //       logger(e.response);
  //       _showResMessageEvent(e.response);
  //       return null;
  //     }
  // }
  // closeLoading();
  // return res;
}

enum ReqType { POST, GET, PUT, PATCH, DELETE }

extension ReqTypeHelper on ReqType {
  String toStr() => toString().replaceAll("ReqType.", "");
}
