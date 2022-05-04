class ShiftId {
  String? status;
  String? shift;
  String? location;
  List<Users1>? users;

  ShiftId({this.status, this.shift, this.location, this.users});

  ShiftId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    shift = json['shift'];
    location = json['location'];
    if (json['users'] != null) {
      users = <Users1>[];
      json['users'].forEach((v) {
        users!.add(new Users1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['shift'] = this.shift;
    data['location'] = this.location;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users1 {
  List<Userid>? userid;

  Users1({this.userid});

  Users1.fromJson(Map<String, dynamic> json) {
    if (json['userid'] != null) {
      userid = <Userid>[];
      json['userid'].forEach((v) {
        userid!.add(new Userid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userid != null) {
      data['userid'] = this.userid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userid {
  String? fullname;
  String? start;
  String? finish;

  Userid({this.fullname, this.start, this.finish});

  Userid.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    start = json['start'];
    finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['start'] = this.start;
    data['finish'] = this.finish;
    return data;
  }
}
