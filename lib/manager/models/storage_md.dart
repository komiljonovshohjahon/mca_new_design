class StorageModel {
  List<Storages>? storages;

  StorageModel({this.storages});

  StorageModel.fromJson(Map<String, dynamic> json) {
    if (json['storages'] != null) {
      storages = <Storages>[];
      json['storages'].forEach((v) {
        storages!.add(Storages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storages != null) {
      data['storages'] = storages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Storages {
  int? id;
  String? name;
  List<Items>? items;

  Storages({this.id, this.name, this.items});

  Storages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? name;
  String? current;
  int? minimum;

  Items({this.id, this.name, this.current, this.minimum});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    current = json['current'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['current'] = this.current;
    data['minimum'] = this.minimum;
    return data;
  }
}
