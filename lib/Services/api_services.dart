import 'package:dio/dio.dart';
import 'package:interview_task/Model/address_model.dart';

class AddressService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://nodeapimongodb-d6ml.onrender.com/api/address",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {"Content-Type": "application/json"},
  ));

  Future<List<AddressModel>> fetchAddresses() async {
    try {
      final response = await _dio.get('/get-address');
      return (response.data['data'] as List)
          .map((json) => AddressModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("Failed to load addresses: $e");
    }
  }


  Future<void> addAddress(AddressModel address) async {
    try {
      await _dio.post('/add-address', data: address.toJson());
    } catch (e) {
      throw Exception("Failed to add address: $e");
    }
  }


  Future<void> updateAddress(String id, AddressModel address) async {
    try {
      await _dio.put('/update-address', data: address.toJson());
    } catch (e) {
      throw Exception("Failed to update address: $e");
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      await _dio.delete('/delete-address', data: {"id": id});
    } catch (e) {
      throw Exception("Failed to delete address: $e");
    }
  }
}
