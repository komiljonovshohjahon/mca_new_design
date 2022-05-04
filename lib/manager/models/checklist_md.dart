import 'dart:convert';

class ChecklistHeadModel {
  ChecklistModel checklist;
  List<Map> rooms;
  List<UsersModel> users;
  ChecklistHeadModel(
      {required this.checklist, required this.rooms, required this.users});
}

//Checklist
class ChecklistModel {
  int? id;
  String? title;
  String? date;
  int? shiftId;
  String? shiftName;
  int? locationId;
  String? locationName;
  String? startTime;
  String? finishTime;
  String? comment;
  String? commentedBy;
  String? commentedOn;
  String? done;

  ChecklistModel(
      {this.id,
      this.title,
      this.date,
      this.shiftId,
      this.shiftName,
      this.locationId,
      this.locationName,
      this.startTime,
      this.finishTime,
      this.comment,
      this.commentedBy,
      this.commentedOn,
      this.done});

  ChecklistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    shiftId = json['shiftId'];
    shiftName = json['shiftName'];
    locationId = json['locationId'];
    locationName = json['locationName'];
    startTime = json['startTime'];
    finishTime = json['finishTime'];
    comment = json['comment'];
    commentedBy = json['commentedBy'];
    commentedOn = json['commentedOn'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['shiftId'] = this.shiftId;
    data['shiftName'] = this.shiftName;
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['startTime'] = this.startTime;
    data['finishTime'] = this.finishTime;
    data['comment'] = this.comment;
    data['commentedBy'] = this.commentedBy;
    data['commentedOn'] = this.commentedOn;
    data['done'] = this.done;
    return data;
  }
}
// //Rooms
// class RoomsModel {
//   Room? room;
//   String? damages;
//   String? damagesBy;
//   String? damagesOn;
//   List<ItemsChecklist>? items;
//
//   RoomsModel(
//       {this.room, this.damages, this.damagesBy, this.damagesOn, this.items});
//
//   RoomsModel.fromJson(Map<String, dynamic> json) {
//     room = json['room'] != null ? new Room.fromJson(json['room']) : null;
//     damages = json['damages'];
//     damagesBy = json['damagesBy'];
//     damagesOn = json['damagesOn'];
//     if (json['items'] != null) {
//       items = <ItemsChecklist>[];
//       json['items'].forEach((v) {
//         items!.add(new ItemsChecklist.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.room != null) {
//       data['room'] = this.room!.toJson();
//     }
//     data['damages'] = this.damages;
//     data['damagesBy'] = this.damagesBy;
//     data['damagesOn'] = this.damagesOn;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

//Rooms
class Room {
  int? id;
  String? name;

  Room({this.id, this.name});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ItemsChecklist {
  int? id;
  int? checklistRoomId;
  String? name;
  dynamic checkedBy;
  String? checkedOn;

  ItemsChecklist(
      {this.id,
      this.checklistRoomId,
      this.name,
      this.checkedBy,
      this.checkedOn});

  ItemsChecklist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checklistRoomId = json['checklistRoomId'];
    name = json['name'];
    checkedBy = json['checkedBy'];
    checkedOn = json['checkedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checklistRoomId'] = this.checklistRoomId;
    data['name'] = this.name;
    data['checkedBy'] = this.checkedBy;
    data['checkedOn'] = this.checkedOn;
    return data;
  }
}

//Damages
class Damages {
  String? damages;
  dynamic damagesBy;
  String? damagesOn;

  Damages({this.damages, this.damagesBy, this.damagesOn});

  Damages.fromJson(Map<String, dynamic> json) {
    damages = json['damages'];
    damagesBy = json['damagesBy'];
    damagesOn = json['damagesOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['damages'] = this.damages;
    data['damagesBy'] = this.damagesBy;
    data['damagesOn'] = this.damagesOn;
    return data;
  }
}

//Photos
class PhotosModel {
  int? id;
  String? photo;
  String? createdOn;
  dynamic createdBy;
  String? photoType;

  PhotosModel(
      {this.id, this.photo, this.createdOn, this.createdBy, this.photoType});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    photoType = json['photoType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['photoType'] = this.photoType;
    return data;
  }
}

//Rooms
class UsersModel {
  int? id;
  int? userId;
  String? fullname;
  String? startTime;
  String? finishTime;

  UsersModel(
      {this.id, this.userId, this.fullname, this.startTime, this.finishTime});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    fullname = json['fullname'];
    startTime = json['startTime'];
    finishTime = json['finishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['fullname'] = this.fullname;
    data['startTime'] = this.startTime;
    data['finishTime'] = this.finishTime;
    return data;
  }
}
