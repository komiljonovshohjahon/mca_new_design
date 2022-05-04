import 'package:flutter/material.dart';

@immutable
class UIState {
  final bool isPublished;
  final bool isUnPublished;
  final bool showloc;
  final dynamic breakTimer;
  UIState({
    required this.isPublished,
    required this.isUnPublished,
    required this.showloc,
    required this.breakTimer,
  });

  factory UIState.initial() {
    return UIState(
      isPublished: false,
      isUnPublished: false,
      showloc: false,
      breakTimer: null,
    );
  }

  UIState copyWith({
    bool? isPublished,
    bool? isUnPublished,
    bool? showloc,
    dynamic breakTimer,
  }) {
    return UIState(
      isPublished: isPublished ?? this.isPublished,
      isUnPublished: isUnPublished ?? this.isUnPublished,
      showloc: showloc ?? this.showloc,
      breakTimer: breakTimer ?? this.breakTimer,
    );
  }
}

//------------------------ Init Action ---------------------------
class UpdateUIAction {
  bool? isPublished;
  bool? isUnPublished;
  bool? showloc;
  dynamic breakTimer;
  UpdateUIAction({
    this.isUnPublished,
    this.isPublished,
    this.showloc,
    this.breakTimer,
  });
}
