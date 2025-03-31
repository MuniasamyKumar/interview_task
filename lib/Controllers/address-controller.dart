import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/Model/address_model.dart';

class AddressController extends GetxController {
  var addresses = <AddressModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  final Dio _dio = Dio();
  final String baseUrl = "https://nodeapimongodb-d6ml.onrender.com/api/address";

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  void fetchAddresses() async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _dio.get("$baseUrl/get-address");

      if (response.data['status'] == true) {
        final List<dynamic> addressData = response.data['data'];
        addresses.clear();
        addresses.addAll(
          addressData
              .map(
                (item) => AddressModel(
                  id: item['_id'],
                  streetAddress: item['streetAddress'],
                  city: item['city'],
                  state: item['state'],
                  postalCode: item['postalCode'],
                  country: item['country'],
                ),
              )
              .toList(),
        );
      } else {
        error.value = response.data['message'] ?? 'Failed to fetch addresses';
      }
    } catch (e) {
      error.value = 'Error fetching addresses: $e';
      print("API Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAddress(AddressModel address) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _dio.post(
        "$baseUrl/add-address",
        data: {
          "streetAddress": address.streetAddress,
          "city": address.city,
          "state": address.state,
          "postalCode": address.postalCode,
          "country": address.country,
        },
      );

      if (response.data['status'] == true) {
        final data = response.data['data'];
        final newAddress = AddressModel(
          id: data['_id'],
          streetAddress: data['streetAddress'],
          city: data['city'],
          state: data['state'],
          postalCode: data['postalCode'],
          country: data['country'],
        );
        addresses.add(newAddress);
        Get.snackbar(
          'Success',
          'Address added successfully',
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        error.value = response.data['message'] ?? 'Failed to add address';
        Get.snackbar(
          'Error',
          error.value,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      error.value = 'Error adding address: $e';
      Get.snackbar(
        'Error',
        'Failed to add address',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      print("API Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress(String id, AddressModel updatedAddress) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _dio.put(
        "$baseUrl/update-address",
        data: {
          "id": id,
          "streetAddress": updatedAddress.streetAddress,
          "city": updatedAddress.city,
          "state": updatedAddress.state,
          "postalCode": updatedAddress.postalCode,
          "country": updatedAddress.country,
        },
      );

      if (response.data['status'] == true) {
        final data = response.data['data'];
        final index = addresses.indexWhere((addr) => addr.id == id);
        if (index != -1) {
          addresses[index] = AddressModel(
            id: data['_id'],
            streetAddress: data['streetAddress'],
            city: data['city'],
            state: data['state'],
            postalCode: data['postalCode'],
            country: data['country'],
          );
        }
        Get.snackbar(
          'Success',
          'Address updated successfully',
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        error.value = response.data['message'] ?? 'Failed to update address';
        Get.snackbar(
          'Error',
          error.value,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      error.value = 'Error updating address: $e';
      Get.snackbar(
        'Error',
        'Failed to update address',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      print("API Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(String id) async {
    isLoading.value = true;
    error.value = '';
    try {
      final response = await _dio.delete(
        "$baseUrl/delete-address",
        data: {"id": id},
      );

      if (response.data['status'] == true) {
        addresses.removeWhere((addr) => addr.id == id);
        Get.snackbar(
          'Success',
          'Address deleted successfully',
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        error.value = response.data['message'] ?? 'Failed to delete address';
        Get.snackbar(
          'Error',
          error.value,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      error.value = 'Error deleting address: $e';
      Get.snackbar(
        'Error',
        'Failed to delete address',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      print("API Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
