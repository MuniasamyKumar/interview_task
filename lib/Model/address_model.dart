class AddressModel {
  String? id;
  String streetAddress;
  String city;
  String state;
  String postalCode;
  String country;

  AddressModel({
    this.id,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      "streetAddress": streetAddress,
      "city": city,
      "state": state,
      "postalCode": postalCode,
      "country": country,
    };
  }


  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      streetAddress: json['streetAddress'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }
}