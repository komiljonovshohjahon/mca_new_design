import 'current_status_md.dart';

class InfosModel {
  List<Current>? current;
  List<Completed>? completed;
  List<Next>? next;
  List<Today>? today;

  InfosModel({this.current, this.completed, this.next, this.today});

  InfosModel.fromJson(Map<String, dynamic> json) {
    if (json['current'] != null) {
      current = <Current>[];
      json['current'].forEach((v) {
        current!.add(new Current.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <Completed>[];
      json['completed'].forEach((v) {
        completed!.add(new Completed.fromJson(v));
      });
    }
    if (json['next'] != null) {
      next = <Next>[];
      json['next'].forEach((v) {
        next!.add(new Next.fromJson(v));
      });
    }
    if (json['today'] != null) {
      today = <Today>[];
      json['today'].forEach((v) {
        today!.add(new Today.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.current != null) {
      data['current'] = this.current!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    if (this.next != null) {
      data['next'] = this.next!.map((v) => v.toJson()).toList();
    }
    if (this.today != null) {
      data['today'] = this.today!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Current {
  int? id;
  String? location;
  String? shift;
  String? start;
  String? finish;

  Current({this.id, this.location, this.shift, this.start, this.finish});

  Current.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    shift = json['shift'];
    start = json['start'];
    finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['shift'] = this.shift;
    data['start'] = this.start;
    data['finish'] = this.finish;
    return data;
  }
}

class Completed {
  String? id;
  String? location;
  String? shift;
  String? start;
  String? finish;

  Completed({this.location, this.shift, this.start, this.finish});

  Completed.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    shift = json['shift'];
    start = json['start'];
    finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['shift'] = this.shift;
    data['start'] = this.start;
    data['finish'] = this.finish;
    return data;
  }
}

class Next {
  String? date;
  String? location;
  String? shift;
  String? start;
  String? finish;
  List<Users>? users;

  Next(
      {this.date,
      this.location,
      this.shift,
      this.start,
      this.finish,
      this.users});

  Next.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    location = json['location'];
    shift = json['shift'];
    start = json['start'];
    finish = json['finish'];
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
    data['location'] = this.location;
    data['shift'] = this.shift;
    data['start'] = this.start;
    data['finish'] = this.finish;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Today {
  int? statusId;
  String? name;
  String? color;
  String? image;
  Start? start;
  Start? finish;

  Today(
      {this.statusId,
      this.name,
      this.color,
      this.image,
      this.start,
      this.finish});

  Today.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    name = json['name'];
    color = json['color'];
    image = json['image'];
    start = json['start'] != null ? new Start.fromJson(json['start']) : null;
    finish = json['finish'] != null ? new Start.fromJson(json['finish']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['name'] = this.name;
    data['color'] = this.color;
    data['image'] = this.image;
    if (this.start != null) {
      data['start'] = this.start!.toJson();
    }
    if (this.finish != null) {
      data['finish'] = this.finish!.toJson();
    }
    return data;
  }
}

class Start {
  String? location;
  String? comment;
  String? timestamp;
  String? displayTime;

  Start({this.location, this.comment, this.timestamp, this.displayTime});

  Start.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    comment = json['comment'];
    timestamp = json['timestamp'];
    displayTime = json['displayTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['comment'] = this.comment;
    data['timestamp'] = this.timestamp;
    data['displayTime'] = this.displayTime;
    return data;
  }
}
