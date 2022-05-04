import 'package:hive_flutter/hive_flutter.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:redux/redux.dart';

Box get getHiveBox => Hive.box(Constants.hiveBoxName);

class HiveMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    // ALWAYS GO BY ORDER switch case -> top to bottom
    //                      functions -> top to bottom
    switch (action.runtimeType) {
      case GetExportHiveAction:
        return _getExportHiveAction(store.state, action, next);
      case GetImportHiveAction:
        return _getImportHiveAction(store.state, action, next);
      case GetDeleteHiveAction:
        return _getDeleteHiveAction(store.state, action, next);
      default:
        return next(action);
    }
  }
///////////////////////DO NOT DECLARE FUNCTIONS BEFORE THIS LINE//////////////////////////

  dynamic _getExportHiveAction(
      AppState state, GetExportHiveAction action, NextDispatcher next) async {
    await getHiveBox.put(action.key, action.value);
    final bool authenticated = action.key == Constants.hiveTokenKey;
    final bool isTest = action.key == Constants.hiveTestKey;
    logger(action.key + "-> " + getHiveBox.get(action.key).toString(),
        hint: 'Get_Export_Hive_Action');
    if (authenticated) {
      next(UpdateInitAction(
          access_token: action.value['access_token'],
          refresh_token: action.value['refresh_token']));
    }
    if (isTest) {
      next(UpdateInitAction(isTest: action.value));
    }
    return action.value;
  }

  dynamic _getImportHiveAction(
      AppState state, GetImportHiveAction action, NextDispatcher next) async {
    var res = getHiveBox.get(action.key);
    final bool authenticated =
        res != null && action.key == Constants.hiveTokenKey;
    final bool isTest = action.key == Constants.hiveTestKey;
    logger(action.key + "-> " + getHiveBox.get(action.key).toString(),
        hint: 'Get_Import_Hive_Action');
    if (authenticated) {
      next(UpdateInitAction(
          access_token: res['access_token'],
          refresh_token: res['refresh_token']));
    }
    if (isTest) {
      if (res == null) {
        await appStore.dispatch(
            GetExportHiveAction(key: Constants.hiveTestKey, value: false));
      }
      next(UpdateInitAction(isTest: res));
    }
    return res;
  }

  Future _getDeleteHiveAction(
      AppState state, GetDeleteHiveAction action, NextDispatcher next) async {
    logger(action.key, hint: 'Get_Delete_Hive_Action');
    await getHiveBox.delete(action.key);
  }

///////////////////////DO NOT DECLARE FUNCTIONS AFTER THIS LINE//////////////////////////

}
