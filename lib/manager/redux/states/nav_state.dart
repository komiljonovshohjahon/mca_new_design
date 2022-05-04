import 'package:flutter/material.dart';
import 'package:mca_new_design/template/base/theme_color.dart';

///
/// NavigationState
///
@immutable
class NavigationState {
  final List history;

  NavigationState({required this.history});

  factory NavigationState.initial() {
    return NavigationState(history: []);
  }

  NavigationState copyWith({List? history}) {
    return NavigationState(history: history ?? this.history);
  }

  String get current {
    int last = history.length - 1;
    return last == -1
        ? 'Page#0'
        : history[last].isPage
            ? 'Page#$last'
            : 'Popup#$last';
  }

  String get currentPage {
    int last = history.lastIndexWhere((v) => v.isPage);
    return last == -1
        ? '/'
        : history[last].name != null
            ? history[last].name
            : '#$last';
  }

  bool isTop(String name) {
    return history.last.name == name;
  }
}

///----------------- Navigation -----------------
class NavigateToAction {
  final String? to;
  final bool replace;
  final dynamic arguments;
  final Widget? page;
  final bool reload;

  NavigateToAction(
      {this.to,
      this.replace = false,
      this.arguments,
      this.page,
      this.reload = false});
}

class NavigateToOrderAction {}

class NavigateToPayListAction {}

class UpdateNavigationAction {
  final String? name;
  final bool? isPage;
  final String? method;

  UpdateNavigationAction({this.name, this.isPage, this.method});
}

class ShowPopupAction<T> {
  final bool barrierDismissible;
  final WidgetBuilder? builder;
  final String? name;

  ShowPopupAction({this.barrierDismissible = true, this.builder, this.name});

  Future<T?> show(BuildContext context) {
    return showDialog<T>(
        context: context,
        barrierColor: ThemeColors.black.withOpacity(0.9),
        barrierDismissible: barrierDismissible,
        builder: builder!,
        routeSettings: RouteSettings(name: name));
  }
}

class DismissPopupAction {
  final bool all;
  final dynamic result;

  DismissPopupAction({this.all = false, this.result});
}
