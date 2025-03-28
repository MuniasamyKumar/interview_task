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
