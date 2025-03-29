import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/Controllers/address-controller.dart';
import 'package:interview_task/Model/address_model.dart';


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

  @override
  void initState() {
    super.initState();
    address = Get.arguments as AddressModel?;
    _initializeControllers();
  }

  void _initializeControllers() {
    streetController = TextEditingController(text: address?.streetAddress ?? "");
    cityController = TextEditingController(text: address?.city ?? "");
    stateController = TextEditingController(text: address?.state ?? "");
    postalController = TextEditingController(text: address?.postalCode ?? "");
    countryController = TextEditingController(text: address?.country ?? "");
  }

  void saveAddress() {
    if (_formKey.currentState!.validate()) {
      AddressModel newAddress = AddressModel(
        id: address?.id,
        streetAddress: streetController.text,
        city: cityController.text,
        state: stateController.text,
        postalCode: postalController.text,
        country: countryController.text,
      );

      if (address == null) {
        addressController.addAddress(newAddress);
      } else {
        addressController.updateAddress(address!.id!, newAddress);
      }

      Get.back(); 
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
      body: SingleChildScrollView(
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
                  Icons.streetview
                ),
                SizedBox(height: 15),
                _buildStyledTextField(
                  cityController, 
                  "City", 
                  Icons.location_city
                ),
                SizedBox(height: 15),
                _buildStyledTextField(
                  stateController, 
                  "State", 
                  Icons.map
                ),
                SizedBox(height: 15),
                _buildStyledTextField(
                  postalController, 
                  "Postal Code", 
                  Icons.local_post_office,
                  isNumeric: true
                ),
                SizedBox(height: 15),
                _buildStyledTextField(
                  countryController, 
                  "Country", 
                  Icons.public
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  child: Text(
                    "Save Address", 
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField(
    TextEditingController controller, 
    String label, 
    IconData icon, 
    {bool isNumeric = false}
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red)
        ),
      ),
      validator: (value) => 
        value!.isEmpty ? "$label is required" : null,
    );
  }
}


// It is for API Integration (My API Facing socket error so i'll solve ASAP)


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:interview_task/Controllers/address-controller.dart';
// import 'package:interview_task/Model/address_model.dart';

// class AddEditAddressScreen extends StatefulWidget {
//   const AddEditAddressScreen({super.key});

//   @override
//   State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
// }

// class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
//   final AddressController addressController = Get.find();
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController streetController;
//   late TextEditingController cityController;
//   late TextEditingController stateController;
//   late TextEditingController postalController;
//   late TextEditingController countryController;

//   AddressModel? address;
//   bool isSubmitting = false;

//   @override
//   void initState() {
//     super.initState();
//     address = Get.arguments as AddressModel?;
//     _initializeControllers();
//   }

//   void _initializeControllers() {
//     streetController = TextEditingController(text: address?.streetAddress ?? "");
//     cityController = TextEditingController(text: address?.city ?? "");
//     stateController = TextEditingController(text: address?.state ?? "");
//     postalController = TextEditingController(text: address?.postalCode ?? "");
//     countryController = TextEditingController(text: address?.country ?? "");
//   }

//   Future<void> saveAddress() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isSubmitting = true;
//       });

//       try {
//         AddressModel newAddress = AddressModel(
//           streetAddress: streetController.text,
//           city: cityController.text,
//           state: stateController.text,
//           postalCode: postalController.text,
//           country: countryController.text,
//         );

//         if (address == null) {
//           await addressController.addAddress(newAddress);
//         } else {
//           await addressController.updateAddress(address!.id, newAddress);
//         }

//         Get.back();
//         Get.snackbar(
//           'Success',
//           address == null ? 'Address added successfully' : 'Address updated successfully',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           margin: EdgeInsets.all(16),
//         );
//       } catch (e) {
//         Get.snackbar(
//           'Error',
//           'Failed to save address: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           margin: EdgeInsets.all(16),
//         );
//       } finally {
//         setState(() {
//           isSubmitting = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           address == null ? "Add Address" : "Edit Address",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.deepPurple,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _buildStyledTextField(
//                   streetController, 
//                   "Street Address", 
//                   Icons.streetview
//                 ),
//                 SizedBox(height: 15),
//                 _buildStyledTextField(
//                   cityController, 
//                   "City", 
//                   Icons.location_city
//                 ),
//                 SizedBox(height: 15),
//                 _buildStyledTextField(
//                   stateController, 
//                   "State", 
//                   Icons.map
//                 ),
//                 SizedBox(height: 15),
//                 _buildStyledTextField(
//                   postalController, 
//                   "Postal Code", 
//                   Icons.local_post_office,
//                   isNumeric: true
//                 ),
//                 SizedBox(height: 15),
//                 _buildStyledTextField(
//                   countryController, 
//                   "Country", 
//                   Icons.public
//                 ),
//                 SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: isSubmitting ? null : saveAddress,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)
//                     )
//                   ),
//                   child: isSubmitting 
//                     ? SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : Text(
//                         "Save Address", 
//                         style: TextStyle(
//                           fontSize: 16, 
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold
//                         )
//                       ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStyledTextField(
//     TextEditingController controller, 
//     String label, 
//     IconData icon, 
//     {bool isNumeric = false}
//   ) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.deepPurple),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.deepPurple)
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300)
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.deepPurple, width: 2)
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.red)
//         ),
//       ),
//       validator: (value) => 
//         value!.isEmpty ? "$label is required" : null,
//     );
//   }
// }