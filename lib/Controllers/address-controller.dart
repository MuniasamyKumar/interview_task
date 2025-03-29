import 'package:get/get.dart';
import 'package:interview_task/Model/address_model.dart';

class AddressController extends GetxController {
  var addresses = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    addresses.addAll([
      AddressModel(id: "1", streetAddress: "123 Main St", city: "New York", state: "NY", postalCode: "10001", country: "USA"),
      AddressModel(id: "2", streetAddress: "456 Elm St", city: "Los Angeles", state: "CA", postalCode: "90001", country: "USA"),
      AddressModel(id: "3", streetAddress: "789 Oak St", city: "Chicago", state: "IL", postalCode: "60601", country: "USA"),
    ]);
  }

  void addAddress(AddressModel address) {
    address.id = DateTime.now().millisecondsSinceEpoch.toString();
    addresses.add(address);
  }

  void updateAddress(String id, AddressModel updatedAddress) {
    int index = addresses.indexWhere((addr) => addr.id == id);
    if (index != -1) {
      addresses[index] = updatedAddress;
    }
  }

  void deleteAddress(String id) {
    addresses.removeWhere((addr) => addr.id == id);
  }
}


// It is for API Integration (My API Facing socket error so i'll solve ASAP)

// import 'package:get/get.dart';
// import 'package:interview_task/Model/address_model.dart';
// import 'package:interview_task/Services/api_services.dart';

// import 'package:uuid/uuid.dart';

// class AddressController extends GetxController {
//   var addresses = <AddressModel>[].obs;
//   final ApiService _apiService = ApiService();
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   final Uuid _uuid = Uuid();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAndPrintUserData();
//     fetchAddresses();
//   }

//   void fetchAndPrintUserData() async {
//   final apiService = ApiService();
//   await apiService.fetchUserData();
// }


//   Future<void> fetchAddresses() async {
//     try {
//       isLoading(true);
//       errorMessage('');
//       final fetchedAddresses = await _apiService.getAddresses();
//       addresses.value = fetchedAddresses;
//     } catch (e) {
//       errorMessage('Error fetching addresses: $e');
//       print(e);
//     } finally {
//       isLoading(false);
//     }
//   }


//   Future<void> addAddress(AddressModel address) async {
//     try {
//       isLoading(true);
//       errorMessage('');


//       String uuidStr = _uuid.v4();
//       int uniqueId = uuidStr.hashCode.abs(); 
//       address.id = uniqueId;

//       final success = await _apiService.addAddress(address);
//       if (success) {
//         await fetchAddresses(); 
//       } else {
//         errorMessage('Failed to add address');
//       }
//     } catch (e) {
//       errorMessage('Error adding address: $e');
//       print(e);
//     } finally {
//       isLoading(false);
//     }
//   }


//   Future<void> updateAddress(dynamic id, AddressModel updatedAddress) async {
//     try {
//       isLoading(true);
//       errorMessage('');

//       updatedAddress.id = id;
//       final success = await _apiService.updateAddress(updatedAddress);

//       if (success) {
//         await fetchAddresses(); 
//       } else {
//         errorMessage('Failed to update address');
//       }
//     } catch (e) {
//       errorMessage('Error updating address: $e');
//       print(e);
//     } finally {
//       isLoading(false);
//     }
//   }


//   Future<void> deleteAddress(dynamic id) async {
//     try {
//       isLoading(true);
//       errorMessage('');

//       final success = await _apiService.deleteAddress(id);

//       if (success) {
//         await fetchAddresses(); 
//       } else {
//         errorMessage('Failed to delete address');
//       }
//     } catch (e) {
//       errorMessage('Error deleting address: $e');
//       print(e);
//     } finally {
//       isLoading(false);
//     }
//   }
// }
