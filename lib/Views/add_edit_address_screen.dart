import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/Controllers/address-controller.dart';
import 'package:interview_task/Model/address_model.dart';
import 'package:interview_task/Views/address_list_screen.dart';

class AddEditAddressScreen extends StatefulWidget {
  const AddEditAddressScreen({super.key});
  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final AddressController addressController = Get.find();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController postalController;
  late TextEditingController countryController;

  AddressModel? address;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    address = Get.arguments as AddressModel?;
    _initializeControllers();
  }

  void _initializeControllers() {
    streetController = TextEditingController(
      text: address?.streetAddress ?? "",
    );
    cityController = TextEditingController(text: address?.city ?? "");
    stateController = TextEditingController(text: address?.state ?? "");
    postalController = TextEditingController(text: address?.postalCode ?? "");
    countryController = TextEditingController(text: address?.country ?? "");
  }

  Future<void> saveAddress() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true;
      });

      AddressModel newAddress = AddressModel(
        id: address?.id,
        streetAddress: streetController.text,
        city: cityController.text,
        state: stateController.text,
        postalCode: postalController.text,
        country: countryController.text,
      );

      try {
        if (address == null) {
          await addressController.addAddress(newAddress);
        } else {
          await addressController.updateAddress(address!.id!, newAddress);
        }

        addressController.fetchAddresses();
        Get.offAll(() => AddressListScreen());
      } catch (e) {
        print("Error saving address: $e");
      } finally {
        if (mounted) {
          setState(() {
            isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          address == null ? "Add Address" : "Edit Address",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildStyledTextField(
                        streetController,
                        "Street Address",
                        Icons.streetview,
                      ),
                      SizedBox(height: 15),
                      _buildStyledTextField(
                        cityController,
                        "City",
                        Icons.location_city,
                      ),
                      SizedBox(height: 15),
                      _buildStyledTextField(
                        stateController,
                        "State",
                        Icons.map,
                      ),
                      SizedBox(height: 15),
                      _buildStyledTextField(
                        postalController,
                        "Postal Code",
                        Icons.local_post_office,
                        isNumeric: true,
                      ),
                      SizedBox(height: 15),
                      _buildStyledTextField(
                        countryController,
                        "Country",
                        Icons.public,
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: isSubmitting ? null : saveAddress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBackgroundColor: Colors.deepPurple
                              .withOpacity(0.6),
                        ),
                        child:
                            isSubmitting
                                ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
                                  "Save Address",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (addressController.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.1),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.deepPurple),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isNumeric = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: (value) => value!.isEmpty ? "$label is required" : null,
    );
  }

  @override
  void dispose() {
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
