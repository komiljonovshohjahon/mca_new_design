class PropertyModel {
  int? shiftId;
  String? shiftName;
  int? locationId;
  String? locationName;
  String? addressLine1;
  String? addressLine2;
  String? addressCity;
  String? addressCounty;
  String? addressCountry;
  String? addressPostcode;
  String? phoneNumberLandline;
  String? phoneNumberMobile;
  String? phoneNumberFax;
  String? clientName;
  String? clientNotes;
  String? storageName;
  List<PropertyItemModel>? items;
  int? bedrooms;
  int? bathrooms;
  int? sleeps_min;
  int? sleeps_max;
  String? notes;

  PropertyModel(
      {this.shiftId,
      this.shiftName,
      this.locationId,
      this.locationName,
      this.addressLine1,
      this.addressLine2,
      this.addressCity,
      this.addressCounty,
      this.addressCountry,
      this.addressPostcode,
      this.phoneNumberLandline,
      this.phoneNumberMobile,
      this.phoneNumberFax,
      this.clientName,
      this.clientNotes,
      this.storageName,
      this.items,
      this.bedrooms,
      this.bathrooms,
      this.sleeps_max,
      this.sleeps_min,
      this.notes});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    locationId = json['location_id'];
    locationName = json['location_name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressCity = json['address_city'];
    addressCounty = json['address_county'];
    addressCountry = json['address_country'];
    addressPostcode = json['address_postcode'];
    phoneNumberLandline = json['phone_number_landline'];
    phoneNumberMobile = json['phone_number_mobile'];
    phoneNumberFax = json['phone_number_fax'];
    clientName = json['client_name'];
    clientNotes = json['client_notes'];
    storageName = json['storage_name'];
    if (json['items'] != null) {
      items = <PropertyItemModel>[];
      json['items'].forEach((v) {
        items?.add(PropertyItemModel.fromJson(v));
      });
    }
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    sleeps_min = json['sleeps_min'];
    sleeps_max = json['sleeps_max'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['location_id'] = this.locationId;
    data['location_name'] = this.locationName;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_city'] = this.addressCity;
    data['address_county'] = this.addressCounty;
    data['address_country'] = this.addressCountry;
    data['address_postcode'] = this.addressPostcode;
    data['phone_number_landline'] = this.phoneNumberLandline;
    data['phone_number_mobile'] = this.phoneNumberMobile;
    data['phone_number_fax'] = this.phoneNumberFax;
    data['client_name'] = this.clientName;
    data['client_notes'] = this.clientNotes;
    data['storage_name'] = this.storageName;
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v.toJson()).toList();
    }
    data['bedrooms'] = this.bedrooms;
    data['bathrooms'] = this.bathrooms;
    data['sleeps_min'] = this.sleeps_min;
    data['sleeps_max'] = this.sleeps_max;
    data['notes'] = this.notes;
    return data;
  }
}

class PropertyItemModel {
  String? name;
  String? stock;
  int? minimum; // Test when this is not null

  PropertyItemModel({this.name, this.stock, this.minimum});

  PropertyItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stock = json['stock'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['stock'] = this.stock;
    data['minimum'] = this.minimum;
    return data;
  }
}
