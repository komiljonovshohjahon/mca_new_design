class AvailableModel {
  Statuses? statuses;
  List<Shifts>? shifts;
  List<Shifts>? completedshifts;
  List<Shifts>? inactiveshifts;
  bool? photoRequired;

  AvailableModel(
      {this.statuses,
      this.shifts,
      this.photoRequired,
      this.completedshifts,
      this.inactiveshifts});

  AvailableModel.fromJson(Map<String, dynamic> json) {
    if (json['shifts'] != null) {
      shifts = <Shifts>[];
      json['shifts'].forEach((v) {
        shifts!.add(Shifts.fromJson(v));
      });
    }
    if (json['completedshifts'] != null) {
      completedshifts = <Shifts>[];
      json['completedshifts'].forEach((v) {
        completedshifts!.add(Shifts.fromJson(v));
      });
    }
    if (json['inactiveshifts'] != null) {
      inactiveshifts = <Shifts>[];
      json['inactiveshifts'].forEach((v) {
        inactiveshifts!.add(Shifts.fromJson(v));
      });
    }
    statuses = json['statuses'].isEmpty
        ? Statuses(list: [])
        : Statuses.fromJson(json['statuses']);
    photoRequired = json['photo_required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shifts != null) {
      data['shifts'] = shifts!.map((v) => v.toJson()).toList();
    }
    if (this.inactiveshifts != null) {
      data['inactiveshifts'] = inactiveshifts!.map((v) => v.toJson()).toList();
    }
    if (this.completedshifts != null) {
      data['completedshifts'] =
          completedshifts!.map((v) => v.toJson()).toList();
    }
    data['photo_required'] = photoRequired;
    data['statuses'] = statuses;
    return data;
  }
}

class Statuses {
  List<CustomList>? list;

  Statuses({this.list});

  Statuses.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CustomList>[];
      json['list'].forEach((v) {
        list!.add(new CustomList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomList {
  int? id;
  String? name;
  String? colour;

  CustomList({this.id, this.name, this.colour});

  CustomList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    colour = json['colour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['colour'] = this.colour;
    return data;
  }
}

class Shifts {
  dynamic id;
  String? name;
  dynamic locationId;

  Shifts({this.id, this.name, this.locationId});

  Shifts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationId = json['locationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['locationId'] = this.locationId;
    return data;
  }
}
