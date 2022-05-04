import 'package:flutter/material.dart';

@immutable
class InitState {
  final String access_token;
  final String refresh_token;
  final bool isLoading;
  final bool isTest;
  final ApiError apiError;
  final String userRole;
  final double longitude;
  final double latitude;
  final String ipaddress;
  final bool isNear;
  final bool checklistOn;

  InitState({
    required this.access_token,
    required this.refresh_token,
    required this.isLoading,
    required this.isTest,
    required this.apiError,
    required this.userRole,
    required this.isNear,
    required this.longitude,
    required this.latitude,
    required this.ipaddress,
    required this.checklistOn,
  });

  factory InitState.initial() {
    return InitState(
      userRole: 'u',
      access_token: '',
      refresh_token: "",
      isLoading: false,
      isTest: false,
      isNear: false,
      latitude: 0.0,
      longitude: 0.0,
      ipaddress: "",
      apiError: ApiError(),
      checklistOn: false,
    );
  }

  InitState copyWith({
    String? access_token,
    String? refresh_token,
    bool? isLoading,
    bool? isTest,
    ApiError? apiError,
    String? userRole,
    bool? isNear,
    double? longitude,
    double? latitude,
    String? ipaddress,
    bool? checklistOn,
  }) {
    return InitState(
      userRole: userRole ?? this.userRole,
      access_token: access_token ?? this.access_token,
      refresh_token: refresh_token ?? this.refresh_token,
      isLoading: isLoading ?? this.isLoading,
      isTest: isTest ?? this.isTest,
      apiError: apiError ?? this.apiError,
      isNear: isNear ?? this.isNear,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      ipaddress: ipaddress ?? this.ipaddress,
      checklistOn: checklistOn ?? this.checklistOn,
    );
  }
}

//------------------------ Init Action ---------------------------
class GetChangeLocaleAction {
  final String? locale;
  GetChangeLocaleAction({this.locale});
}

class UpdateInitAction {
  final String? access_token;
  final String? refresh_token;
  final bool? isLoading;
  final bool? isTest;
  final ApiError? apiError;
  final String? userRole;
  final bool? isNear;
  final bool isReset;
  final double? longitude;
  final double? latitude;
  final String? ipaddress;
  final bool? checklistOn;

  UpdateInitAction({
    this.refresh_token,
    this.access_token,
    this.isLoading,
    this.isTest,
    this.userRole,
    this.apiError,
    this.isNear,
    this.ipaddress,
    this.latitude,
    this.longitude,
    this.checklistOn,
    this.isReset = false,
  });
}

class ApiError {
  String? error;
  String? error_description;
  ApiError({this.error, this.error_description});

  ApiError.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    error_description = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_description'] = this.error_description;
    return data;
  }
}
