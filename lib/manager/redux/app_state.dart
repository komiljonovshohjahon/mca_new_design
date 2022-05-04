import 'package:flutter_redux/flutter_redux.dart';
import 'package:mca_new_design/manager/redux/middleware/api_middeware.dart';
import 'package:mca_new_design/manager/redux/middleware/hive_middleware.dart';
import 'package:mca_new_design/manager/redux/middleware/login_middleware.dart';
import 'package:mca_new_design/manager/redux/middleware/models_middleware.dart';
import 'package:mca_new_design/manager/redux/reducer.dart';
import 'package:mca_new_design/manager/redux/states/init_state.dart';
import 'package:mca_new_design/manager/redux/states/models_state.dart';
import 'package:mca_new_design/manager/redux/states/nav_state.dart';
import 'package:mca_new_design/manager/redux/states/ui_state.dart';
import 'package:redux/redux.dart';

import '../../template/base/template.dart';
import 'middleware/navigation_middleware.dart';

AppState GETSTATE(BuildContext context) =>
    StoreProvider.of<AppState>(context).state;

final appStore = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    ApiMiddleware(),
    HiveMiddleware(),
    LoginMiddleware(),
    ModelsMiddleware(),
    NavigationMiddleware(),
  ],
);

@immutable
class AppState {
  final NavigationState navigationState;
  final InitState initState;
  final ModelsState modelsState;
  final UIState uiState;

  AppState({
    required this.navigationState,
    required this.initState,
    required this.modelsState,
    required this.uiState,
  });

  factory AppState.initial() {
    return AppState(
      navigationState: NavigationState.initial(),
      initState: InitState.initial(),
      modelsState: ModelsState.initial(),
      uiState: UIState.initial(),
    );
  }

  AppState copyWith({
    NavigationState? navigationState,
    InitState? initState,
    ModelsState? modelsState,
    UIState? uiState,
  }) {
    return AppState(
      navigationState: navigationState ?? this.navigationState,
      initState: initState ?? this.initState,
      modelsState: modelsState ?? this.modelsState,
      uiState: uiState ?? this.uiState,
    );
  }
}
