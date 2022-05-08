import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_fake.dart';
import 'package:mca_new_design/manager/models/model_exporter.dart';

@immutable
class ModelsState {
  final CurrentStatusModel currentStatusModel;
  final DetailsModel detailsModel;
  final AvailableModel availableModel;
  final PhotoModel photoModel;
  final CompanyModel companyModel;
  final InfosModel infosModel;
  final Map dailyProgress;
  final Map currentStock;
  final Map mobileAdmin;
  final Map timesheet;
  final List<ReqTypeModel> reqTypes;
  final MsgTypes messages;
  final List<String> locations;
  final StorageModel storageModel;
  final ChecklistHeadModel checklistModel;
  final List<PropertyModel> properties;

  ModelsState({
    required this.currentStatusModel,
    required this.detailsModel,
    required this.availableModel,
    required this.photoModel,
    required this.companyModel,
    required this.infosModel,
    required this.currentStock,
    required this.dailyProgress,
    required this.mobileAdmin,
    required this.timesheet,
    required this.reqTypes,
    required this.messages,
    required this.locations,
    required this.storageModel,
    required this.checklistModel,
    required this.properties,
  });

  factory ModelsState.initial() {
    return ModelsState(
        currentStatusModel: CurrentStatusModel(),
        detailsModel: DetailsModel(),
        availableModel: AvailableModel(),
        photoModel: PhotoModel(),
        companyModel: CompanyModel(),
        infosModel: InfosModel(),
        dailyProgress: {},
        currentStock: {},
        mobileAdmin: {},
        timesheet: {},
        reqTypes: [],
        messages: MsgTypes(message: []),
        locations: [],
        storageModel: StorageModel(storages: []),
        checklistModel: ChecklistHeadModel(
            checklist: ChecklistModel(), rooms: [], users: []),
        properties: []);
  }

  ModelsState copyWith({
    CurrentStatusModel? currentStatusModel,
    DetailsModel? detailsModel,
    AvailableModel? availableModel,
    PhotoModel? photoModel,
    CompanyModel? companyModel,
    InfosModel? infosModel,
    Map? currentStock,
    Map? dailyProgress,
    Map? mobileAdmin,
    Map? timesheet,
    List<ReqTypeModel>? reqTypes,
    MsgTypes? messages,
    List<String>? locations,
    StorageModel? storageModel,
    ChecklistHeadModel? checklistModel,
    List<PropertyModel>? properties,
  }) {
    return ModelsState(
      currentStatusModel: currentStatusModel ?? this.currentStatusModel,
      detailsModel: detailsModel ?? this.detailsModel,
      availableModel: availableModel ?? this.availableModel,
      photoModel: photoModel ?? this.photoModel,
      companyModel: companyModel ?? this.companyModel,
      infosModel: infosModel ?? this.infosModel,
      currentStock: currentStock ?? this.currentStock,
      dailyProgress: dailyProgress ?? this.dailyProgress,
      mobileAdmin: mobileAdmin ?? this.mobileAdmin,
      timesheet: timesheet ?? this.timesheet,
      reqTypes: reqTypes ?? this.reqTypes,
      messages: messages ?? this.messages,
      locations: locations ?? this.locations,
      storageModel: storageModel ?? this.storageModel,
      checklistModel: checklistModel ?? this.checklistModel,
      properties: properties ?? this.properties,
    );
  }
}

//------------------------ Models Action ---------------------------

class GetModelsInitAction {
  VoidCallback? successAction;
  GetModelsInitAction({this.successAction});
}

class GetDetailsAction {}

class GetCurrentStatusAction {}

class GetAvailableAction {}

class GetPhotoAction {}

class GetCompanyAction {}

class GetInfosAction {}

class GetCurrentStockAction {}

class GetDailyProgressAction {}

class GetMobileAdminAction {
  String? date;
  GetMobileAdminAction({this.date});
}

class GetPostMobileAdminAction {
  int? shiftId;
  String action;
  GetPostMobileAdminAction({required this.action, this.shiftId});
}

class GetTimesheetAction {}

class GetReqTypesAction {}

class GetPostHolidayAction {
  int type_id;
  String start_date;
  String? end_date;
  String? start_time;
  String? end_time;
  String? comment;
  GetPostHolidayAction(
      {required this.type_id,
      required this.start_date,
      this.comment,
      this.end_date,
      this.end_time,
      this.start_time});
}

class GetPostUnavAction {
  String? date_from;
  String? date_to;
  bool? fullday;
  String? time_from;
  String? time_to;
  String? comment;
  int? id;
  bool revoke;
  GetPostUnavAction({
    this.comment,
    this.id,
    this.revoke = false,
    this.date_from,
    this.date_to,
    this.fullday,
    this.time_from,
    this.time_to,
  });
}

class GetPostCurrentStatusAction {
  final int? status_id;
  final String? shift_id;
  final String? comment;
  final bool undo;
  final String? base64Image;
  GetPostCurrentStatusAction(
      {this.comment,
      this.base64Image,
      this.shift_id,
      this.status_id,
      this.undo = false});
}

class GetMessagesAction {
  final String type;
  final String? limit;
  final String? from;
  GetMessagesAction({required this.type, this.limit, this.from});
}

class GetLocationAction {}

class GetStorageAction {}

class GetPostStoragesAction {
  final int storageid;
  final int targetid;
  final Map<String, String> items;
  final String? docno;
  final String? comment;
  GetPostStoragesAction(
      {this.comment,
      required this.items,
      required this.storageid,
      this.docno,
      required this.targetid});
}

class GetChecklistAction {}

class GetPropertiesAction {}

class GetPostChecklistAction {
  final int checklistId;
  final List<int?> checked;
  final Map<String, String> comments;
  final Map<String, String> images;

  GetPostChecklistAction(
      {required this.checklistId,
      required this.checked,
      required this.comments,
      required this.images});
}

class UpdateModelsAction {
  DetailsModel? detailsModel;
  CurrentStatusModel? currentStatusModel;
  AvailableModel? availableModel;
  PhotoModel? photoModel;
  CompanyModel? companyModel;
  InfosModel? infosModel;
  Map? currentStock;
  Map? dailyProgress;
  Map? mobileAdmin;
  Map? timesheet;
  List<ReqTypeModel>? reqTypes;
  MsgTypes? messages;
  List<String>? locations;
  StorageModel? storageModel;
  ChecklistHeadModel? checklistModel;
  List<PropertyModel>? properties;
  UpdateModelsAction({
    this.currentStatusModel,
    this.detailsModel,
    this.availableModel,
    this.properties,
    this.photoModel,
    this.companyModel,
    this.infosModel,
    this.currentStock,
    this.dailyProgress,
    this.mobileAdmin,
    this.timesheet,
    this.reqTypes,
    this.messages,
    this.locations,
    this.storageModel,
    this.checklistModel,
  });
}
