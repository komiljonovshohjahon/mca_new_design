// class MobileAdminModel {
//   List<Locations>? locations;
//   List<Users>? users;
//   List<Shifts>? shifts;
//   List<Allocations>? allocations;
//
//   MobileAdminModel({this.locations, this.users, this.shifts, this.allocations});
//
//   MobileAdminModel.fromJson(Map<String, dynamic> json) {
//     if (json['locations'] != null) {
//       locations = <Locations>[];
//       json['locations'].forEach((v) {
//         locations!.add(new Locations.fromJson(v));
//       });
//     }
//     if (json['users'] != null) {
//       users = <Users>[];
//       json['users'].forEach((v) {
//         users!.add(new Users.fromJson(v));
//       });
//     }
//     if (json['shifts'] != null) {
//       shifts = <Shifts>[];
//       json['shifts'].forEach((v) {
//         shifts!.add(new Shifts.fromJson(v));
//       });
//     }
//     if (json['allocations'] != null) {
//       allocations = <Allocations>[];
//       json['allocations'].forEach((v) {
//         allocations!.add(new Allocations.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.locations != null) {
//       data['locations'] = this.locations!.map((v) => v.toJson()).toList();
//     }
//     if (this.users != null) {
//       data['users'] = this.users!.map((v) => v.toJson()).toList();
//     }
//     if (this.shifts != null) {
//       data['shifts'] = this.shifts!.map((v) => v.toJson()).toList();
//     }
//     if (this.allocations != null) {
//       data['allocations'] = this.allocations!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
class AdminLocations {
  String? key;
  String? value;

  AdminLocations({this.key, this.value});

  AdminLocations.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class AdminUsers {
  String? key;
  AdminUser? value;

  AdminUsers({this.key, this.value});

  AdminUsers.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class AdminUser {
  String? id;
  String? username;
  String? title;
  String? firstName;
  String? lastName;
  String? lastTime;
  String? lastStatus;
  String? lastIpAddress;
  String? lastLocationId;
  String? lastLatitude;
  String? lastLongitude;
  String? payrolCode;
  String? lastComment;
  bool? loginRequired;
  bool? locked;
  String? fullname;

  AdminUser(
      {this.id,
      this.username,
      this.title,
      this.firstName,
      this.lastName,
      this.lastTime,
      this.lastStatus,
      this.lastIpAddress,
      this.lastLocationId,
      this.lastLatitude,
      this.lastLongitude,
      this.payrolCode,
      this.lastComment,
      this.loginRequired,
      this.locked,
      this.fullname});

  AdminUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    lastTime = json['lastTime'];
    lastStatus = json['lastStatus'];
    lastIpAddress = json['lastIpAddress'];
    lastLocationId = json['lastLocationId'];
    lastLatitude = json['lastLatitude'];
    lastLongitude = json['lastLongitude'];
    payrolCode = json['payrolCode'];
    lastComment = json['lastComment'];
    loginRequired = json['loginRequired'];
    locked = json['locked'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['lastTime'] = this.lastTime;
    data['lastStatus'] = this.lastStatus;
    data['lastIpAddress'] = this.lastIpAddress;
    data['lastLocationId'] = this.lastLocationId;
    data['lastLatitude'] = this.lastLatitude;
    data['lastLongitude'] = this.lastLongitude;
    data['payrolCode'] = this.payrolCode;
    data['lastComment'] = this.lastComment;
    data['loginRequired'] = this.loginRequired;
    data['locked'] = this.locked;
    data['fullname'] = this.fullname;
    return data;
  }
}
//
// class Shifts {
//   String? distance;
//   List<Location>? location;
//   List<Shifts>? shifts;
//
//   Shifts({this.distance, this.location, this.shifts});
//
//   Shifts.fromJson(Map<String, dynamic> json) {
//     distance = json['distance'];
//     if (json['location'] != null) {
//       location = <Location>[];
//       json['location'].forEach((v) {
//         location!.add(new Location.fromJson(v));
//       });
//     }
//     if (json['shifts'] != null) {
//       shifts = <Shifts>[];
//       json['shifts'].forEach((v) {
//         shifts!.add(new Shifts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['distance'] = this.distance;
//     if (this.location != null) {
//       data['location'] = this.location!.map((v) => v.toJson()).toList();
//     }
//     if (this.shifts != null) {
//       data['shifts'] = this.shifts!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Shifts {
//   String? shiftId;
//   String? title;
//   String? timings;
//   List<Days>? days;
//
//   Shifts({this.shiftId, this.title, this.timings, this.days});
//
//   Shifts.fromJson(Map<String, dynamic> json) {
//     shiftId = json['shiftId'];
//     title = json['title'];
//     timings = json['timings'];
//     if (json['days'] != null) {
//       days = <Days>[];
//       json['days'].forEach((v) {
//         days!.add(new Days.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['shiftId'] = this.shiftId;
//     data['title'] = this.title;
//     data['timings'] = this.timings;
//     if (this.days != null) {
//       data['days'] = this.days!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Days {
//   String? key;
//   bool? value;
//
//   Days({this.key, this.value});
//
//   Days.fromJson(Map<String, dynamic> json) {
//     key = json['key'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['key'] = this.key;
//     data['value'] = this.value;
//     return data;
//   }
// }
//
// class Allocations {
//   String? title;
//   String? startTime;
//   String? finishTime;
//   String? fpStartTime;
//   String? fpFinishTime;
//   String? fpStartBreak;
//   String? fpFinishBreak;
//   bool? strictBreak;
//   String? startBreak;
//   String? finishBreak;
//   int? minWorkTime;
//   int? minPaidTime;
//   bool? splitTime;
//   int? id;
//   int? userOrder;
//   bool? published;
//   String? shiftId;
//   String? date;
//   String? specialStartTime;
//   String? specialFinishTime;
//   String? userId;
//   String? releaseStatus;
//   String? releaseRequestedOn;
//   int? releaseRequestedBy;
//   String? releaseRequestComment;
//   String? releasePublishedOn;
//   String? releasePublishedBy;
//   String? releasePublishComment;
//   String? locationId;
//   String? locationName;
//   String? userTitle;
//   String? userFirstName;
//   String? userLastName;
//   String? userFullname;
//
//   Allocations(
//       {this.title,
//         this.startTime,
//         this.finishTime,
//         this.fpStartTime,
//         this.fpFinishTime,
//         this.fpStartBreak,
//         this.fpFinishBreak,
//         this.strictBreak,
//         this.startBreak,
//         this.finishBreak,
//         this.minWorkTime,
//         this.minPaidTime,
//         this.splitTime,
//         this.id,
//         this.userOrder,
//         this.published,
//         this.shiftId,
//         this.date,
//         this.specialStartTime,
//         this.specialFinishTime,
//         this.userId,
//         this.releaseStatus,
//         this.releaseRequestedOn,
//         this.releaseRequestedBy,
//         this.releaseRequestComment,
//         this.releasePublishedOn,
//         this.releasePublishedBy,
//         this.releasePublishComment,
//         this.locationId,
//         this.locationName,
//         this.userTitle,
//         this.userFirstName,
//         this.userLastName,
//         this.userFullname});
//
//   Allocations.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     startTime = json['startTime'];
//     finishTime = json['finishTime'];
//     fpStartTime = json['fpStartTime'];
//     fpFinishTime = json['fpFinishTime'];
//     fpStartBreak = json['fpStartBreak'];
//     fpFinishBreak = json['fpFinishBreak'];
//     strictBreak = json['strictBreak'];
//     startBreak = json['startBreak'];
//     finishBreak = json['finishBreak'];
//     minWorkTime = json['minWorkTime'];
//     minPaidTime = json['minPaidTime'];
//     splitTime = json['splitTime'];
//     id = json['id'];
//     userOrder = json['userOrder'];
//     published = json['published'];
//     shiftId = json['shiftId'];
//     date = json['date'];
//     specialStartTime = json['specialStartTime'];
//     specialFinishTime = json['specialFinishTime'];
//     userId = json['userId'];
//     releaseStatus = json['releaseStatus'];
//     releaseRequestedOn = json['releaseRequestedOn'];
//     releaseRequestedBy = json['releaseRequestedBy'];
//     releaseRequestComment = json['releaseRequestComment'];
//     releasePublishedOn = json['releasePublishedOn'];
//     releasePublishedBy = json['releasePublishedBy'];
//     releasePublishComment = json['releasePublishComment'];
//     locationId = json['locationId'];
//     locationName = json['locationName'];
//     userTitle = json['userTitle'];
//     userFirstName = json['userFirstName'];
//     userLastName = json['userLastName'];
//     userFullname = json['userFullname'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['startTime'] = this.startTime;
//     data['finishTime'] = this.finishTime;
//     data['fpStartTime'] = this.fpStartTime;
//     data['fpFinishTime'] = this.fpFinishTime;
//     data['fpStartBreak'] = this.fpStartBreak;
//     data['fpFinishBreak'] = this.fpFinishBreak;
//     data['strictBreak'] = this.strictBreak;
//     data['startBreak'] = this.startBreak;
//     data['finishBreak'] = this.finishBreak;
//     data['minWorkTime'] = this.minWorkTime;
//     data['minPaidTime'] = this.minPaidTime;
//     data['splitTime'] = this.splitTime;
//     data['id'] = this.id;
//     data['userOrder'] = this.userOrder;
//     data['published'] = this.published;
//     data['shiftId'] = this.shiftId;
//     data['date'] = this.date;
//     data['specialStartTime'] = this.specialStartTime;
//     data['specialFinishTime'] = this.specialFinishTime;
//     data['userId'] = this.userId;
//     data['releaseStatus'] = this.releaseStatus;
//     data['releaseRequestedOn'] = this.releaseRequestedOn;
//     data['releaseRequestedBy'] = this.releaseRequestedBy;
//     data['releaseRequestComment'] = this.releaseRequestComment;
//     data['releasePublishedOn'] = this.releasePublishedOn;
//     data['releasePublishedBy'] = this.releasePublishedBy;
//     data['releasePublishComment'] = this.releasePublishComment;
//     data['locationId'] = this.locationId;
//     data['locationName'] = this.locationName;
//     data['userTitle'] = this.userTitle;
//     data['userFirstName'] = this.userFirstName;
//     data['userLastName'] = this.userLastName;
//     data['userFullname'] = this.userFullname;
//     return data;
//   }
// }
