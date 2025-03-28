// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Controllers/auth_controller.dart';

// class PhoneNumberScreen extends StatelessWidget {
//   PhoneNumberScreen({super.key});

//   final AuthController authController = Get.put(AuthController());
//   final TextEditingController phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xFF673AB7),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xFF673AB7).withOpacity(0.3),
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         )
//                       ],
//                     ),
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.handshake_outlined,
//                           size: 80,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Welcome',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 15,
//                           vertical: 15
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF673AB7),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           '+91',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(width: 10),

//                       Expanded(
//                         child: TextFormField(
//                           controller: phoneController,
//                           keyboardType: TextInputType.phone,
//                           maxLength: 10,
//                           decoration: InputDecoration(
//                             hintText: 'Enter 10-digit Mobile Number',
//                             fillColor: Colors.white,
//                             filled: true,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 15,
//                               vertical: 15
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: Color(0xFF673AB7),
//                                 width: 2,
//                               ),
//                             ),
//                             counterText: '',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter mobile number';
//                             }
//                             if (value.length != 10) {
//                               return 'Mobile number must be 10 digits';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 30),

//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         String fullPhoneNumber = '+91${phoneController.text}';
//                         authController.verifyPhoneNumber(fullPhoneNumber);
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF673AB7),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: Text(
//                       'Send OTP',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.1,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_number/mobile_number.dart';
// import '../Controllers/auth_controller.dart';

// class PhoneNumberScreen extends StatefulWidget {
//   const PhoneNumberScreen({super.key});

//   @override
//   _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
// }

// class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
//   final AuthController authController = Get.put(AuthController());
//   final TextEditingController phoneController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   _buildHeader(),
//                   const SizedBox(height: 30),
//                   _buildPhoneNumberField(),
//                   const SizedBox(height: 30),
//                   _buildSendOTPButton(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Builds the welcome header
//   Widget _buildHeader() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF673AB7),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF673AB7).withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           const Icon(Icons.handshake_outlined, size: 80, color: Colors.white),
//           const SizedBox(height: 10),
//           const Text(
//             'Welcome',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Builds the phone number input field with SIM selection
//   Widget _buildPhoneNumberField() {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           decoration: BoxDecoration(
//             color: const Color(0xFF673AB7),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Text(
//             '+91',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: TextFormField(
//             controller: phoneController,
//             keyboardType: TextInputType.phone,
//             maxLength: 10,
//             decoration: InputDecoration(
//               hintText: 'Enter or Select Mobile Number',
//               fillColor: Colors.white,
//               filled: true,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 15,
//                 vertical: 15,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: const BorderSide(
//                   color: Color(0xFF673AB7),
//                   width: 2,
//                 ),
//               ),
//               counterText: '',
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.sim_card, color: Color(0xFF673AB7)),
//                 onPressed: _selectSIMNumber,
//               ),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter mobile number';
//               }
//               if (value.length != 10) {
//                 return 'Mobile number must be 10 digits';
//               }
//               return null;
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   /// Builds the "Send OTP" button
//   Widget _buildSendOTPButton() {
//     return ElevatedButton(
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           String fullPhoneNumber = '+91${phoneController.text}';
//           authController.verifyPhoneNumber(fullPhoneNumber);
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF673AB7),
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       ),
//       child: const Text(
//         'Send OTP',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 1.1,
//         ),
//       ),
//     );
//   }

//   Future<void> _selectSIMNumber() async {
//     try {
//       // Request permission
//       bool? hasPermission = await MobileNumber.hasPhonePermission;
//       if (!hasPermission!) {
//         await MobileNumber.requestPhonePermission;
//       }

//       // Fetch SIM details
//       List<SimCard> sims = await MobileNumber.getSimCards ?? [];

//       if (sims.isEmpty) {
//         Get.snackbar(
//           "Error",
//           "No SIM card found",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }

//       List<String> simNumbers =
//           sims
//               .map((sim) => sim.number) // Use correct property
//               .where(
//                 (num) => num != null && num.isNotEmpty,
//               ) // Null and empty check
//               .cast<String>()
//               .toList();

//       if (simNumbers.isEmpty) {
//         Get.snackbar(
//           "Error",
//           "No mobile numbers available",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }

//       _showSIMSelectionDialog(simNumbers);
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to fetch SIM details",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   /// Fetch SIM numbers and show a dialog for selection
//   // // Future<void> _selectSIMNumber() async {
//   // //   try {
//   // //     SimData simData = await SimDataPlugin.getSimData();
//   // //     List<SimCard> sims = simData.cards;

//   // //     if (sims.isEmpty) {
//   // //       Get.snackbar("Error", "No SIM card found", backgroundColor: Colors.red, colorText: Colors.white);
//   // //       return;
//   // //     }

//   // //     // Fetch SIM numbers correctly
//   // //     List<String> simNumbers = sims
//   // //         .map((sim) => sim.phoneNumber) // Use phoneNumber instead of number
//   // //         .where((num) => num != null && num.isNotEmpty) // Null and empty check
//   // //         .cast<String>() // Cast to non-nullable String
//   // //         .toList();

//   // //     if (simNumbers.isEmpty) {
//   // //       Get.snackbar("Error", "No mobile numbers available", backgroundColor: Colors.red, colorText: Colors.white);
//   // //       return;
//   // //     }

//   // //     _showSIMSelectionDialog(simNumbers);
//   // //   } catch (e) {
//   // //     Get.snackbar("Error", "Failed to fetch SIM details", backgroundColor: Colors.red, colorText: Colors.white);
//   // //   }
//   // }

//   /// Displays a dialog to select SIM 1 or SIM 2
//   void _showSIMSelectionDialog(List<String> simNumbers) {
//     Get.dialog(
//       AlertDialog(
//         title: const Text("Select SIM"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children:
//               simNumbers.map((number) {
//                 return ListTile(
//                   title: Text(number),
//                   onTap: () {
//                     phoneController.text =
//                         number.startsWith('+91') ? number.substring(3) : number;
//                     Get.back(); // Close dialog
//                   },
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_number/mobile_number.dart';
import '../Controllers/auth_controller.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildPhoneNumberField(),
                  const SizedBox(height: 30),
                  _buildSendOTPButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the welcome header
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF673AB7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF673AB7).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.handshake_outlined, size: 80, color: Colors.white),
          const SizedBox(height: 10),
          const Text(
            'Welcome',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the phone number input field with SIM selection
  Widget _buildPhoneNumberField() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF673AB7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            '+91',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              hintText: 'Enter or Select Mobile Number',
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF673AB7),
                  width: 2,
                ),
              ),
              counterText: '',
              suffixIcon: IconButton(
                icon: const Icon(Icons.sim_card, color: Color(0xFF673AB7)),
                onPressed: _selectSIMNumber,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter mobile number';
              }
              if (value.length != 10) {
                return 'Mobile number must be 10 digits';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  /// Builds the "Send OTP" button
  Widget _buildSendOTPButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          String fullPhoneNumber = '+91${phoneController.text}';
          authController.verifyPhoneNumber(fullPhoneNumber);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF673AB7),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: const Text(
        'Send OTP',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.1),
      ),
    );
  }

  /// Fetch SIM numbers and show a dialog for selection
  Future<void> _selectSIMNumber() async {
    try {
      // Request permission
      bool? hasPermission = await MobileNumber.hasPhonePermission;
      if (!hasPermission!) {
        await MobileNumber.requestPhonePermission;
      }

      // Fetch SIM details
      List<SimCard> sims = await MobileNumber.getSimCards ?? [];

      if (sims.isEmpty) {
        Get.snackbar("Error", "No SIM card found", backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      // Ensure both SIM slots are shown, even if one number is missing
      List<Map<String, String>> simList = sims.map((sim) {
        return {
          'slot': "SIM ${sim.slotIndex! + 1}", // Show SIM slot
          'number': sim.number ?? 'Unknown',  // Use "Unknown" if number is empty
        };
      }).toList();

      _showSIMSelectionDialog(simList);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch SIM details", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// Displays a dialog to select SIM 1 or SIM 2
  void _showSIMSelectionDialog(List<Map<String, String>> simList) {
    Get.dialog(
      AlertDialog(
        title: const Text("Select SIM"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: simList.map((sim) {
            return ListTile(
              title: Text("${sim['slot']}: ${sim['number']}"),
              onTap: () {
                if (sim['number'] != 'Unknown') {
                  phoneController.text = sim['number']!.startsWith('+91')
                      ? sim['number']!.substring(3)
                      : sim['number']!;
                } else {
                  Get.snackbar("Error", "No number available for ${sim['slot']}", backgroundColor: Colors.red, colorText: Colors.white);
                }
                Get.back(); // Close dialog
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
