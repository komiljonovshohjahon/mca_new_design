import 'package:mca_new_design/template/base/template.dart';

class CurrentStatusModel {
  String? date;
  String? color;
  String? status;
  int? statusId;
  String? location;
  String? shift;
  String? start;
  String? finish;
  Options? options;
  List<Users>? users;

  CurrentStatusModel(
      {this.date,
      this.status,
      this.color,
      this.statusId,
      this.location,
      this.shift,
      this.start,
      this.finish,
      this.options,
      this.users});

  CurrentStatusModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    color = json['color'];
    status = json['status'];
    statusId = json['statusId'];
    location = json['location'];
    shift = json['shift'];
    start = json['start'];
    finish = json['finish'];
    options = Options.fromJson(json['options']);
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['status'] = this.status;
    data['statusId'] = this.statusId;
    data['color'] = this.color;
    data['location'] = this.location;
    data['shift'] = this.shift;
    data['start'] = this.start;
    data['finish'] = this.finish;
    data['options'] = this.options?.toJson();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  bool? startTimer;
  String? timerStart;
  bool? checklist;
  bool? stocklist;

  Options({this.startTimer, this.timerStart, this.checklist, this.stocklist});

  Options.fromJson(Map<String, dynamic> json) {
    startTimer = json['startTimer'];
    timerStart = json['timerStart'];
    checklist = json['checklist'];
    stocklist = json['stocklist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTimer'] = this.startTimer;
    data['timerStart'] = this.timerStart;
    data['checklist'] = this.checklist;
    data['stocklist'] = this.stocklist;
    return data;
  }
}

class Users {
  int? id;
  String? username;
  String? title;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? location;
  String? department;
  String? locale;

  Users(
      {this.id,
      this.username,
      this.title,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.location,
      this.department,
      this.locale});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    location = json['location'];
    department = json['department'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['date_of_birth'] = this.dateOfBirth;
    data['location'] = this.location;
    data['department'] = this.department;
    data['locale'] = this.locale;
    return data;
  }
}
