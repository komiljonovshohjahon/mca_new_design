import 'package:flutter/foundation.dart';
import 'package:mca_new_design/manager/redux/states/init_state.dart';
import 'package:mca_new_design/manager/redux/states/models_state.dart';
import 'package:mca_new_design/manager/redux/states/nav_state.dart';
import 'package:mca_new_design/manager/redux/states/ui_state.dart';
import 'package:mca_new_design/template/base/template.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) {
  var newState = state.copyWith(
    navigationState: _navReducer(state.navigationState, action),
    initState: _initReducer(state.initState, action),
    modelsState: _modelsReducer(state.modelsState, action),
    uiState: _uiReducer(state.uiState, action),
  );

  return newState;
}

///
/// Navigation Reducer
///
final _navReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, UpdateNavigationAction>(_updateNavigationState),
]);

NavigationState _updateNavigationState(
    NavigationState state, UpdateNavigationAction action) {
  print(
      '--- NAVIGATE TO ${action.name} (${action.isPage! ? 'PAGE' : 'POPUP'}) by ${action.method!.toUpperCase()} ---');
  var history = List.from(state.history);

  switch (action.method) {
    case 'push':
      if (action.name == '/') {
        history.insert(0, action);
      } else {
        history.add(action);
      }
      break;
    case 'pop':
      if (history.isNotEmpty) {
        history.removeLast();
      }
      break;
    case 'replace':
      if (history.isNotEmpty) {
        history.removeLast();
      }

      history.add(action);
      break;
  }

  if (kDebugMode) {
    print('------------HISTORY-------------');

    for (var i in history.reversed) {
      print('${i.isPage ? 'page' : 'popup'} - ${i.name}');
    }

    print('--------------------------------');
  }

  return state.copyWith(history: history);
}

///
/// Init Reducer
///
final _initReducer = combineReducers<InitState>(
    [TypedReducer<InitState, UpdateInitAction>(_updateInitState)]);

InitState _updateInitState(InitState state, UpdateInitAction action) {
  if (action.isReset) {
    return InitState.initial();
  }
  return state.copyWith(
    access_token: action.access_token ?? state.access_token,
    refresh_token: action.refresh_token ?? state.refresh_token,
    isLoading: action.isLoading ?? state.isLoading,
    isTest: action.isTest ?? state.isTest,
    apiError: action.apiError ?? state.apiError,
    userRole: action.userRole ?? state.userRole,
    isNear: action.isNear ?? state.isNear,
    ipaddress: action.ipaddress ?? state.ipaddress,
    longitude: action.longitude ?? state.longitude,
    latitude: action.latitude ?? state.latitude,
    checklistOn: action.checklistOn ?? state.checklistOn,
  );
}

///
/// Models Reducer
///
final _modelsReducer = combineReducers<ModelsState>(
    [TypedReducer<ModelsState, UpdateModelsAction>(_updateModelsState)]);

ModelsState _updateModelsState(ModelsState state, UpdateModelsAction action) {
  return state.copyWith(
    currentStatusModel: action.currentStatusModel ?? state.currentStatusModel,
    detailsModel: action.detailsModel ?? state.detailsModel,
    availableModel: action.availableModel ?? state.availableModel,
    photoModel: action.photoModel ?? state.photoModel,
    companyModel: action.companyModel ?? state.companyModel,
    infosModel: action.infosModel ?? state.infosModel,
    currentStock: action.currentStock ?? state.currentStock,
    dailyProgress: action.dailyProgress ?? state.dailyProgress,
    mobileAdmin: action.mobileAdmin ?? state.mobileAdmin,
    timesheet: action.timesheet ?? state.timesheet,
    reqTypes: action.reqTypes ?? state.reqTypes,
    messages: action.messages ?? state.messages,
    locations: action.locations ?? state.locations,
    storageModel: action.storageModel ?? state.storageModel,
    checklistModel: action.checklistModel ?? state.checklistModel,
  );
}

///
/// UI Reducer
///
final _uiReducer = combineReducers<UIState>(
    [TypedReducer<UIState, UpdateUIAction>(_updateUIState)]);

UIState _updateUIState(UIState state, UpdateUIAction action) {
  return state.copyWith(
    isPublished: action.isPublished ?? state.isPublished,
    isUnPublished: action.isUnPublished ?? state.isUnPublished,
    showloc: action.showloc ?? state.showloc,
    breakTimer: action.breakTimer ?? state.breakTimer,
  );
}
