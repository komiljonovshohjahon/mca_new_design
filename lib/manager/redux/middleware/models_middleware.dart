import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' as GETX;
import 'package:get/get_core/src/get_main.dart';
import 'package:mca_new_design/manager/models/model_exporter.dart';
import 'package:mca_new_design/manager/periodic_actions.dart';
import 'package:mca_new_design/manager/redux/middleware/api_middeware.dart';
import 'package:mca_new_design/manager/rest/api_service_client.dart';
import 'package:mca_new_design/pages/adminstration_location_screen.dart';
import 'package:mca_new_design/pages/main_screen.dart';
import 'package:mca_new_design/pages/timesheet_screen.dart';
import 'package:mca_new_design/utils/common/helpers.dart';
import 'package:mca_new_design/utils/common/log_tester.dart';
import 'package:redux/redux.dart';
import 'package:dart_ipify/dart_ipify.dart';
import '../../../utils/common/constants.dart';
import '../../../utils/format/date_format.dart';
import '../../navigation/routes_get.dart';
import '../action.dart';
import '../app_state.dart';
import '../states/init_state.dart';
import '../states/models_state.dart';
import 'package:timezone/standalone.dart' as tz;

class ModelsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    // ALWAYS GO BY ORDER switch case -> top to bottom
    //                      functions -> top to bottom
    switch (action.runtimeType) {
      case GetModelsInitAction:
        return _getModelsInitAction(store.state, action, next);
      case GetCurrentStatusAction:
        return _getCurrentStatusAction(store.state, action, next);
      case GetDetailsAction:
        return _getDetailsAction(store.state, action, next);
      case GetAvailableAction:
        return _getAvailableAction(store.state, action, next);
      case GetPhotoAction:
        return _getPhotoAction(store.state, action, next);
      case GetCompanyAction:
        return _getCompanyAction(store.state, action, next);
      case GetInfosAction:
        return _getInfosAction(store.state, action, next);
      case GetCurrentStockAction:
        return _getCurrentStockAction(store.state, action, next);
      case GetDailyProgressAction:
        return _getDailyProgressAction(store.state, action, next);
      case GetPostCurrentStatusAction:
        return _getPostCurrentStatusAction(store.state, action, next);
      case GetPostMobileAdminAction:
        return _getPostMobileAdminAction(store.state, action, next);
      case GetMobileAdminAction:
        return _getMobileAdminAction(store.state, action, next);
      case GetTimesheetAction:
        return _getTimesheetAction(store.state, action, next);
      case GetReqTypesAction:
        return _getReqTypesAction(store.state, action, next);
      case GetPostHolidayAction:
        return _getPostHolidayAction(store.state, action, next);
      case GetPostUnavAction:
        return _getPostUnavAction(store.state, action, next);
      case GetMessagesAction:
        return _getMessagesAction(store.state, action, next);
      case GetLocationAction:
        return _getLocationAction(store.state, action, next);
      case GetStorageAction:
        return _getStorageAction(store.state, action, next);
      case GetPostStoragesAction:
        return _getPostStoragesAction(store.state, action, next);
      case GetChecklistAction:
        return _getChecklistAction(store.state, action, next);
      case GetPostChecklistAction:
        return _getPostChecklistAction(store.state, action, next);
      case GetPropertiesAction:
        return _getPropertiesAction(store.state, action, next);
      default:
        return next(action);
    }
  }

///////////////////////DO NOT DECLARE FUNCTIONS BEFORE THIS LINE//////////////////////////
  _getModelsInitAction(
      AppState state, GetModelsInitAction action, NextDispatcher next) async {
    final renewedToken = await appStore.dispatch(GetRenewAccessTokenAction());
    if (renewedToken != null) {
      await appStore.dispatch(GetCompanyAction());
      await appStore.dispatch(GetLocationAction());
      await appStore.dispatch(GetDetailsAction());
      await appStore.dispatch(GetPhotoAction());
      await appStore.dispatch(GetAvailableAction());
      await appStore.dispatch(GetCurrentStatusAction());
      await appStore.dispatch(GetReqTypesAction());
      if (action.successAction != null) action.successAction!();
    } else {
      appStore.replace(AppRoutes.RouteToSignUp);
    }
  }

  _getCurrentStatusAction(AppState state, GetCurrentStatusAction action,
      NextDispatcher next) async {
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeCurrentStatus,
        reqType: ReqType.GET));
    if (res != null) {
      final model = CurrentStatusModel.fromJson(res.data);
      next(UpdateModelsAction(currentStatusModel: model));
      if (model.options != null) {
        //Checklist
        if (model.options!.checklist != null && model.options!.checklist!) {
          await appStore.dispatch(GetChecklistAction());
        } else {
          next(UpdateInitAction(checklistOn: false));
        }
        TimerController controller = Get.find();
        //Timer
        if (model.options!.startTimer != null && model.options!.startTimer!) {
          if (MainScreen.breakTimer == null) {
            MainScreen.breakTimer = Timer.periodic(1.seconds, (timer) {
              final usertimezon =
                  tz.getLocation(state.modelsState.companyModel.timezone!);
              final breaktimer = model.options?.timerStart;
              final dateTimeBreak = DateTime.parse(breaktimer!);
              final dateTimeNow =
                  tz.TZDateTime.from(DateTime.now(), usertimezon);
              final difference = Duration(
                  days: dateTimeNow.day - dateTimeBreak.day,
                  hours: dateTimeNow.hour - dateTimeBreak.hour,
                  minutes: dateTimeNow.minute - dateTimeBreak.minute,
                  seconds: dateTimeNow.second - dateTimeBreak.second,
                  microseconds:
                      dateTimeNow.microsecond - dateTimeBreak.microsecond,
                  milliseconds:
                      dateTimeNow.millisecond - dateTimeBreak.millisecond);
              final dotIndex = difference.toString().indexOf('.');
              final formattedDiff =
                  difference.toString().substring(0, dotIndex);
              // logger('Timer is running');
              controller.startTimer(formattedDiff);
            });
          } else {}
        } else {
          if (MainScreen.breakTimer != null) {
            MainScreen.breakTimer!.cancel();
          }
          MainScreen.breakTimer = null;
          controller.stopTimer();
        }
      }
      //Success
    } else {
      //Fail
    }
  }

  _getDetailsAction(
      AppState state, GetDetailsAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(
        GetRunApiFetchAction(ApiInvokes.invokeDetails, reqType: ReqType.GET));
    if (res != null) {
      //Success
      final model = DetailsModel.fromJson(res.data);
      appStore.dispatch(GetExportHiveAction(
          key: Constants.hiveLocaleKey, value: model.locale));
      await appStore.dispatch(GetChangeLocaleAction(locale: model.locale));
      next(UpdateInitAction(
          userRole: model.role != null || model.role!.isNotEmpty
              ? model.role!.toLowerCase().substring(0, 1)
              : "m"));
      next(UpdateModelsAction(detailsModel: model));
    } else {
      //Fail
    }
  }

  _getAvailableAction(
      AppState state, GetAvailableAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeAvailable,
        params: {'sections': 1},
        reqType: ReqType.GET));
    if (res != null) {
      //Success
      final model = AvailableModel.fromJson(res.data);
      next(UpdateModelsAction(availableModel: model));
    } else {
      //Fail
    }
  }

  _getPhotoAction(
      AppState state, GetPhotoAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokePhoto,
        reqType: ReqType.GET,
        showErrorPopup: false));
    if (res != null) {
      //Success
      final model = PhotoModel.fromJson(res.data);
      next(UpdateModelsAction(photoModel: model));
    } else {
      //Fail
    }
  }

  _getCompanyAction(
      AppState state, GetCompanyAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(
        GetRunApiFetchAction(ApiInvokes.invokeCompany, reqType: ReqType.GET));
    if (res != null) {
      //Success
      final model = CompanyModel.fromJson(res.data);
      var detroit = tz.getLocation(model.timezone!);
      tz.setLocalLocation(detroit);
      next(UpdateModelsAction(companyModel: model));
    } else {
      //Fail
    }
  }

  _getInfosAction(
      AppState state, GetInfosAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeInformations,
        reqType: ReqType.GET));
    if (res != null) {
      //Success
      final model = InfosModel.fromJson(res.data);
      next(UpdateModelsAction(infosModel: model));
    } else {
      //Fail
    }
  }

  Future<Map?> _getCurrentStockAction(
      AppState state, GetCurrentStockAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeCurrentStock,
        reqType: ReqType.GET));
    if (res != null) {
      //Success
      next(UpdateModelsAction(currentStock: res.data));
      return res.data;
    } else {
      //Fail
    }
  }

  _getDailyProgressAction(AppState state, GetDailyProgressAction action,
      NextDispatcher next) async {
    final Response? res = await appStore.dispatch(
        GetRunApiFetchAction(ApiInvokes.invokeProgress, reqType: ReqType.GET));
    if (res != null) {
      //Success
      next(UpdateModelsAction(dailyProgress: res.data));
    } else {
      //Fail
    }
  }

  Future<Map?> _getMobileAdminAction(
      AppState state, GetMobileAdminAction action, NextDispatcher next) async {
    final Map<String, dynamic> params = {};

    if (action.date != null) {
      params['date'] = action.date;
    }

    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeMobileAdmin,
        params: params,
        reqType: ReqType.GET));
    if (res != null) {
      //Success
      next(UpdateModelsAction(mobileAdmin: res.data));
      return res.data;
    } else {
      //Fail
    }
  }

  _getPostCurrentStatusAction(AppState state, GetPostCurrentStatusAction action,
      NextDispatcher next) async {
    if (action.shift_id == null) {
      appStore.snackbar('select_shift');
    } else {
      showLoadingDialog();
      final String undo = action.undo ? "1" : "0";
      final String? ipAddr = await getDeviceIpAction();
      final Position? deviceLoc = await getDeviceLocation();
      if (deviceLoc == null) {
        appStore.snackbar('location_error');
      } else {
        final Response? res = await appStore
            .dispatch(GetRunApiFetchAction(ApiInvokes.invokeCurrentStatus,
                data: {
                  "status_id": action.status_id,
                  "shift_id": action.shift_id,
                  "ip_address ": ipAddr,
                  "latitude": deviceLoc.longitude,
                  "longitude": deviceLoc.longitude,
                  "comment": action.comment,
                  "undo": undo,
                  "image": action.base64Image
                },
                reqType: ReqType.POST));
        // closeLoading();
        if (res != null) {
          //Success
          await appStore.dispatch(GetCurrentStatusAction());
          await appStore.dispatch(GetAvailableAction());
          closeLoading();
          // await appStore.dispatch(
          //     GetModelsInitAction(successAction: () => closeLoading()));
        } else {
          //Fail
        }
      }
    }
  }

  Future _getTimesheetAction(
      AppState state, GetTimesheetAction action, NextDispatcher next) async {
    final Response? res =
        await appStore.dispatch(GetRunApiFetchAction(ApiInvokes.invokeTimesheet,
            params: {
              "from": getDateFormat(TimesheetScreen.fromDate),
              "until": getDateFormat(TimesheetScreen.toDate),
              "holidays": true
            },
            reqType: ReqType.GET));
    if (res != null) {
      //Success
      Map resVals = {}..addAll(res.data);
      resVals.removeWhere((key, value) =>
          DateTime.parse(key)
              .compareTo(TimesheetScreen.fromDate.subtract(1.days)) ==
          -1);
      resVals.removeWhere((key, value) =>
          DateTime.parse(key).compareTo(TimesheetScreen.toDate) == 1);
      next(UpdateModelsAction(timesheet: resVals));
      return res.data;
    } else {
      //Fail
    }
  }

  Future _getReqTypesAction(
      AppState state, GetReqTypesAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeRequestType,
        reqType: ReqType.GET));
    if (res != null) {
      //Success
      List<ReqTypeModel> list = [];
      list.addAll(res.data['list']
          .map<ReqTypeModel>((e) => ReqTypeModel.fromJson(e))
          .toList());
      next(UpdateModelsAction(reqTypes: list));
      return res.data;
    } else {
      //Fail
    }
  }

  Future _getPostHolidayAction(
      AppState state, GetPostHolidayAction action, NextDispatcher next) async {
    showLoadingDialog();
    FormData formData = FormData();
    formData.fields
      ..add(MapEntry('type_id', action.type_id.toString()))
      ..add(MapEntry('start_date', action.start_date.toString()))
      ..add(MapEntry('end_date', action.end_date.toString()))
      ..add(MapEntry('comment', action.comment.toString()));
    logger(formData.fields, hint: 'FormData fields <->');
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeHoliday,
        data: formData,
        reqType: ReqType.POST));
    if (res != null) {
      //Success
      await appStore.dispatch(GetTimesheetAction());
      appStore.pop();
      appStore.pop();
    } else {
      //Fail
    }
  }

  Future _getPostUnavAction(
      AppState state, GetPostUnavAction action, NextDispatcher next) async {
    showLoadingDialog();
    if (action.revoke) {
      //On revoke unav date
      final Response? res = await appStore.dispatch(GetRunApiFetchAction(
          ApiInvokes.invokeUnavailable,
          params: {"id": action.id},
          reqType: ReqType.DELETE));
      if (res != null) {
        //Success
        await appStore.dispatch(GetTimesheetAction());
        closeLoading();
      } else {
        //Fail
      }
    } else {
      //On add unav date
      FormData formData = FormData();
      formData.fields
        ..add(MapEntry('date_from', action.date_from.toString()))
        ..add(MapEntry('date_to', action.date_to.toString()))
        ..add(MapEntry('fullday', action.fullday.toString()))
        ..add(MapEntry('time_to', action.time_to.toString()))
        ..add(MapEntry('comment', action.comment.toString()))
        ..add(MapEntry('time_from', action.time_from.toString()));
      logger(formData.fields, hint: 'FormData fields <->');
      final Response? res = await appStore.dispatch(GetRunApiFetchAction(
          ApiInvokes.invokeUnavailable,
          data: formData,
          reqType: ReqType.POST));
      if (res != null) {
        //Success
        await appStore.dispatch(GetTimesheetAction());
        closeLoading();
        appStore.pop();
      } else {
        //Fail
      }
    }
  }

  _getPostMobileAdminAction(AppState state, GetPostMobileAdminAction action,
      NextDispatcher next) async {
    showLoadingDialog();
    final int _oldLocId = int.parse(
        AdministrationLocationScreen.selectedLocation['location']!['key']!);
    final int _oldUserId = int.parse(
        AdministrationLocationScreen.selectedLocation['user']!['key']!);
    Map<String, dynamic> data = {
      'action': action.action,
      "shift": action.shiftId,
      "location": _oldLocId,
    };
    if (action.action == "add" || action.action == "remove") {
      data.addAll({"user": _oldUserId});
    }
    if (action.action == "publish" || action.action == "unpublish") {
      data.remove("shift");
    }

    FormData formData = FormData.fromMap(data);
    logger(formData.fields, hint: 'FormData fields <->');
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeMobileAdmin,
        data: formData,
        closeLoadingOnError: true,
        reqType: ReqType.POST));
    if (res != null) {
      //Success
      await appStore.dispatch(GetMobileAdminAction());
      closeLoading();
      appStore.pop();
      Future.delayed(400.milliseconds,
          () => appStore.to(AppRoutes.RouteToAdministrationAvailableShifts));
    } else {
      //Fail
    }
  }

  Future _getMessagesAction(
      AppState state, GetMessagesAction action, NextDispatcher next) async {
    final Map<String, dynamic> params = {};
    params['type'] = action.type;
    params['limit'] = action.limit;
    params['from'] = action.from;
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeMessages,
        params: params,
        reqType: ReqType.GET));
    if (res != null) {
      //Success
      List<MessageModel> list = state.modelsState.messages.message;
      MessageSummaryModel? messageSummary;
      if (res.data.containsKey("messages")) {
        list.clear();
        list.addAll(res.data['messages']
            .map<MessageModel>((e) => MessageModel.fromJson(e))
            .toList());
      }
      if (res.data.containsKey("all")) {
        messageSummary = MessageSummaryModel.fromJson(res.data);
      }
      next(UpdateModelsAction(
          messages: MsgTypes(message: list, messageSummary: messageSummary)));
      return messageSummary;
    } else {
      //Fail
    }
  }

  _getLocationAction(
      AppState state, GetLocationAction action, NextDispatcher next) async {
    final Position? deviceLoc = await getDeviceLocation();
    final String? deviceIpaddress = await getDeviceIpAction();
    Map<String, dynamic> params = {};
    if (deviceLoc != null) {
      params['latitude'] = deviceLoc.latitude;
      params['longitude'] = deviceLoc.longitude;
      params['ip_address'] = deviceIpaddress;
      next(UpdateInitAction(
          ipaddress: deviceIpaddress,
          longitude: deviceLoc.longitude,
          latitude: deviceLoc.latitude));
    }

    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeLocation,
        params: params,
        reqType: ReqType.GET));
    if (res != null) {
      logger(res.data, hint: 'Location data');
      //Success
      final List<String> locs =
          res.data['location'].map<String>((e) => e.toString()).toList();
      final bool isNear = locs.isNotEmpty;
      next(UpdateModelsAction(locations: locs));
      next(UpdateInitAction(isNear: isNear));
    } else {
      //Fail
    }
  }

  Future _getStorageAction(
      AppState state, GetStorageAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(
        GetRunApiFetchAction(ApiInvokes.invokeStorage, reqType: ReqType.GET));
    if (res != null) {
      //Success
      final model = StorageModel.fromJson(res.data);
      next(UpdateModelsAction(storageModel: model));
      return model;
    } else {
      //Fail
    }
  }

  Future _getPostStoragesAction(
      AppState state, GetPostStoragesAction action, NextDispatcher next) async {
    final String finalItems =
        base64.encode(utf8.encode(jsonEncode(action.items)));
    final String finalDocNo =
        base64.encode(utf8.encode(jsonEncode(action.docno)));
    final String finalComment =
        base64.encode(utf8.encode(jsonEncode(action.comment)));
    FormData formData = FormData();
    formData.fields
      ..add(MapEntry('targetid', action.targetid.toString()))
      ..add(MapEntry('storageid', action.storageid.toString()))
      ..add(MapEntry('items', finalItems))
      ..add(MapEntry('docno', finalDocNo))
      ..add(MapEntry('comment', finalComment));
    logger(formData.fields, hint: 'FormData fields <->');
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeStorage,
        data: formData,
        reqType: ReqType.POST));
    if (res != null) {
      //   Success
    } else {
      //Fail
    }
  }

  _getChecklistAction(
      AppState state, GetChecklistAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(
        GetRunApiFetchAction(ApiInvokes.invokeChecklist, reqType: ReqType.GET));
    if (res != null) {
      next(UpdateInitAction(checklistOn: true));
      //Checklist
      final ChecklistModel checklistModel =
          ChecklistModel.fromJson(res.data['list']['checklist']);

      //Rooms
      final Map roomsModel = res.data['list']['rooms'];
      final List<Map> roomsList = roomsModel.values.map<Map>((e) => e).toList();
      //Users
      final List<UsersModel> users = res.data['list']['users']
          .map<UsersModel>((e) => UsersModel.fromJson(e))
          .toList();

      //Success
      final model = ChecklistHeadModel(
          users: users, rooms: roomsList, checklist: checklistModel);
      next(UpdateModelsAction(checklistModel: model));
      return model;
    } else {
      //Fail
    }
  }

  Future _getPostChecklistAction(AppState state, GetPostChecklistAction action,
      NextDispatcher next) async {
    showLoadingDialog();
    final String finalComment =
        base64.encode(utf8.encode(jsonEncode(action.comments)));
    final String finalImages =
        base64.encode(utf8.encode(jsonEncode(action.images)));
    FormData formData = FormData.fromMap({
      "id": action.checklistId,
      "checked": jsonEncode(action.checked),
      "comments": finalComment,
      "images": finalImages,
    });
    logger(formData.fields, hint: 'FormData fields <->');
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeChecklist,
        data: formData,
        reqType: ReqType.POST));
    if (res != null) {
      //   Success
      appStore.to('up');
      appStore.to(AppRoutes.RouteToChecklist);
    } else {
      closeLoading();
      //Fail
    }
  }

  _getPropertiesAction(
      AppState state, GetPropertiesAction action, NextDispatcher next) async {
    final Response? res = await appStore.dispatch(GetRunApiFetchAction(
        ApiInvokes.invokeProperties,
        reqType: ReqType.GET));
    if (res != null) {
      List<PropertyModel> properties = [];
      properties = res.data['list']
          .map<PropertyModel>((e) => PropertyModel.fromJson(e))
          .toList();
      //Success
      next(UpdateModelsAction(properties: properties));
      return properties;
    } else {
      //Fail
    }
  }
///////////////////////DO NOT DECLARE FUNCTIONS AFTER THIS LINE//////////////////////////
}

Future<String?> getDeviceIpAction() async {
  final ipv4 = await Ipify.ipv4();
  return ipv4;
}

Future<Position?> getDeviceLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
// Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      appStore.snackbar('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    appStore.snackbar(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();

  ////
  // Location location = Location();
  // bool _serviceEnabled;
  // PermissionStatus _permissionGranted;
  // LocationData _locationData;
  //
  // _serviceEnabled = await location.serviceEnabled();
  // if (!_serviceEnabled) {
  //   _serviceEnabled = await location.requestService();
  //   if (!_serviceEnabled) {
  //     return null;
  //   }
  // }
  //
  // _permissionGranted = await location.hasPermission();
  // if (_permissionGranted == PermissionStatus.denied) {
  //   _permissionGranted = await location.requestPermission();
  //   if (_permissionGranted != PermissionStatus.granted) {
  //     appStore.snackbar('location_perm_denied');
  //     return null;
  //   }
  // }
  //
  // _locationData = await location.getLocation();
  // return _locationData;
}
