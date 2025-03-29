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

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      streetAddress: json['street_address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'country': country,
    };
  }
}

// It is for API Integration (My API Facing socket error so i'll solve ASAP)


// class AddressModel {
//   int? id;
//   String streetAddress;
//   String city;
//   String state;
//   String postalCode;
//   String country;

//   AddressModel({
//     this.id,
//     required this.streetAddress,
//     required this.city,
//     required this.state,
//     required this.postalCode,
//     required this.country,
//   });

//   factory AddressModel.fromJson(Map<String, dynamic> json) {
//     return AddressModel(
//       id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
//       streetAddress: json['streetAddress'] ?? "",
//       city: json['city'] ?? "",
//       state: json['state'] ?? "",
//       postalCode: json['postalCode'] ?? "",
//       country: json['country'] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'streetAddress': streetAddress,
//       'city': city,
//       'state': state,
//       'postalCode': postalCode,
//       'country': country,
//     };
//   }
// }
