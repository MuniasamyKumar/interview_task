
// It is for API Integration (My API Facing socket error so i'll solve ASAP)

// import 'package:dio/dio.dart';
// import 'package:interview_task/Model/address_model.dart';

// class ApiService {
//   final Dio _dio = Dio();
//   final String baseUrl = 'https://nodeapi-production-4904.up.railway.app/address';

//   Future<List<AddressModel>> getAddresses() async {
//     try {
//       final response = await _dio.get('$baseUrl/get-address');
      
//       if (response.statusCode == 200 && response.data['status'] == true) {
//         List<dynamic> addressesData = response.data['data'];
//         return addressesData.map((addressData) => AddressModel.fromJson(addressData)).toList();
//       } else {
//         throw Exception('Failed to load addresses: ${response.data['message']}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching addresses: $e');
//     }
//   }

//   Future<bool> addAddress(AddressModel address) async {
//     try {
//       final response = await _dio.post('$baseUrl/add-address', data: {
//         'id': address.id,
//         'streetAddress': address.streetAddress,
//         'city': address.city,
//         'state': address.state,
//         'postalCode': address.postalCode,
//         'country': address.country
//       });
      
//       return response.statusCode == 200 && response.data['status'] == true;
//     } catch (e) {
//       throw Exception('Error adding address: $e');
//     }
//   }

//   Future<bool> updateAddress(AddressModel address) async {
//     try {
//       final response = await _dio.put('$baseUrl/update-address', data: {
//         'id': address.id,
//         'streetAddress': address.streetAddress,
//         'city': address.city,
//         'state': address.state,
//         'postalCode': address.postalCode,
//         'country': address.country
//       });
      
//       return response.statusCode == 200 && response.data['status'] == true;
//     } catch (e) {
//       throw Exception('Error updating address: $e');
//     }
//   }


//   Future<bool> deleteAddress(dynamic id) async {
//     try {
//       final response = await _dio.post('$baseUrl/delete-address', data: {
//         'id': id
//       });
      
//       return response.statusCode == 200 && response.data['status'] == true;
//     } catch (e) {
//       throw Exception('Error deleting address: $e');
//     }
//   }
// }
