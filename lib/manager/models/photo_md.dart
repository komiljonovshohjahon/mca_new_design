class PhotoModel {
  String? type;
  String? photo;
  String? thumbnail;
  String? comment;

  PhotoModel({this.type, this.photo, this.thumbnail, this.comment});

  PhotoModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    photo = json['photo'];
    thumbnail = json['thumbnail'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['photo'] = this.photo;
    data['thumbnail'] = this.thumbnail;
    data['comment'] = this.comment;
    return data;
  }
}
