import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:interview_task/Controllers/address-controller.dart';
import 'package:interview_task/Model/address_model.dart';
import 'add_edit_address_screen.dart';

class AddressListScreen extends StatelessWidget {
  final AddressController addressController = Get.find<AddressController>();

  AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Addresses',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddEditAddressScreen()),
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        }

        if (addressController.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
                SizedBox(height: 16),
                Text(
                  'Error loading addresses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    addressController.error.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => addressController.fetchAddresses(),
                  icon: Icon(Icons.refresh),
                  label: Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        }

        if (addressController.addresses.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_off, size: 100, color: Colors.grey[300]),
                SizedBox(height: 20),
                Text(
                  'No addresses added yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: addressController.addresses.length,
          itemBuilder: (context, index) {
            final address = addressController.addresses[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed:
                          (context) => Get.to(
                            () => AddEditAddressScreen(),
                            arguments: address,
                          ),
                      backgroundColor: Colors.blue,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) => _showDeleteConfirmation(address),
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    '${address.streetAddress}, ${address.city}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${address.state}, ${address.country} ${address.postalCode}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    child: Icon(Icons.location_on, color: Colors.deepPurple),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showDeleteConfirmation(AddressModel address) {
    Get.defaultDialog(
      title: "Delete Address",
      titleStyle: TextStyle(
        color: Colors.deepPurple,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      middleText: "Are you sure you want to delete this address?",
      middleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
      contentPadding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      radius: 10,
      barrierDismissible: false,
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            addressController.deleteAddress(address.id!);
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
