class TimesheetModel {
  int? shiftId;
  String? shift;
  String? location;
  String? agreedStartTime;
  String? agreedFinishTime;
  String? actualStartTime;
  String? actualFinishTime;
  int? agreedtime;
  int? worktime;
  String? holiday;

  TimesheetModel(
      {this.shiftId,
      this.shift,
      this.agreedStartTime,
      this.agreedFinishTime,
      this.actualStartTime,
      this.actualFinishTime,
      this.location,
      this.agreedtime,
      this.worktime,
      this.holiday});

  TimesheetModel.fromJson(Map<String, dynamic> json) {
    shiftId = json['shiftId'];
    shift = json['shift'];
    agreedStartTime = json['agreedStartTime'];
    agreedFinishTime = json['agreedFinishTime'];
    actualStartTime = json['actualStartTime'];
    actualFinishTime = json['actualFinishTime'];
    agreedtime = json['agreedtime'];
    worktime = json['worktime'];
    holiday = json['holiday'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shiftId'] = this.shiftId;
    data['shift'] = this.shift;
    data['agreedStartTime'] = this.agreedStartTime;
    data['agreedFinishTime'] = this.agreedFinishTime;
    data['actualStartTime'] = this.actualStartTime;
    data['actualFinishTime'] = this.actualFinishTime;
    data['agreedtime'] = this.agreedtime;
    data['worktime'] = this.worktime;
    data['holiday'] = this.holiday;
    data['location'] = this.location;
    return data;
  }
}

class HolidayModel {
  String? type;
  int? reqId;
  int? reqType;
  String? name;
  String? startDate;
  int? fullday;
  String? status;
  String? endDate;
  String? comment;
  String? date;

  HolidayModel(
      {this.type,
      this.reqId,
      this.reqType,
      this.name,
      this.startDate,
      this.fullday,
      this.status,
      this.endDate,
      this.comment,
      this.date});

  HolidayModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    reqId = json['req_id'];
    reqType = json['req_type'];
    name = json['name'];
    startDate = json['start_date'];
    fullday = json['fullday'];
    status = json['status'];
    endDate = json['end_date'];
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['req_id'] = this.reqId;
    data['req_type'] = this.reqType;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['fullday'] = this.fullday;
    data['status'] = this.status;
    data['end_date'] = this.endDate;
    data['comment'] = this.comment;
    data['date'] = this.date;
    return data;
  }
}

class UnavailableModel {
  int? availabilityId;
  String? dateFrom;
  String? dateUntil;
  bool? fullday;
  String? timeFrom;
  String? timeUntil;
  String? comment;

  UnavailableModel(
      {this.availabilityId,
      this.dateFrom,
      this.dateUntil,
      this.fullday,
      this.timeFrom,
      this.timeUntil,
      this.comment});

  UnavailableModel.fromJson(Map<String, dynamic> json) {
    availabilityId = json['availabilityId'];
    dateFrom = json['dateFrom'];
    dateUntil = json['dateUntil'];
    fullday = json['fullday'];
    timeFrom = json['timeFrom'];
    timeUntil = json['timeUntil'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['availabilityId'] = this.availabilityId;
    data['dateFrom'] = this.dateFrom;
    data['dateUntil'] = this.dateUntil;
    data['fullday'] = this.fullday;
    data['timeFrom'] = this.timeFrom;
    data['timeUntil'] = this.timeUntil;
    data['comment'] = this.comment;
    return data;
  }
}

class ReqTypeModel {
  int? typeId;
  String? name;
  String? initial;
  String? comment;
  bool? fullday;
  bool? allocationRequired;
  bool? startTime;
  bool? finishTime;
  bool? paid;

  ReqTypeModel(
      {this.typeId,
      this.name,
      this.initial,
      this.comment,
      this.fullday,
      this.allocationRequired,
      this.startTime,
      this.finishTime,
      this.paid});

  ReqTypeModel.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    name = json['name'];
    initial = json['initial'];
    comment = json['comment'];
    fullday = json['fullday'];
    allocationRequired = json['allocation_required'];
    startTime = json['start_time'];
    finishTime = json['finish_time'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['name'] = this.name;
    data['initial'] = this.initial;
    data['comment'] = this.comment;
    data['fullday'] = this.fullday;
    data['allocation_required'] = this.allocationRequired;
    data['start_time'] = this.startTime;
    data['finish_time'] = this.finishTime;
    data['paid'] = this.paid;
    return data;
  }
}
