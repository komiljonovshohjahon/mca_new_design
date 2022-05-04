class CompanyModel {
  String? name;
  String? timezone;
  String? logo;
  String? type;

  CompanyModel({this.name, this.timezone, this.logo, this.type});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timezone = json['timezone'];
    logo = json['logo'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['timezone'] = this.timezone;
    data['logo'] = this.logo;
    data['type'] = this.type;
    return data;
  }
}
