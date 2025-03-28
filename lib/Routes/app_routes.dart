// // import 'package:get/get.dart';
// // import 'package:interview_task/Views/add_edit_address_screen.dart';
// // import 'package:interview_task/Views/address_list_screen.dart';


// // class AppRoutes {
// //   static const home = '/';
// //   static const addEditAddress = '/addEditAddress';

// //   static List<GetPage> routes = [
// //     GetPage(name: home, page: () => AddressListScreen()),
// //     GetPage(name: addEditAddress, page: () => AddEditAddressScreen()),
// //   ];
// // }


// import 'package:get/get.dart';
// import 'package:interview_task/Views/otp_screen.dart';
// import 'package:interview_task/Views/phone_number_screen.dart';

// class AppRoutes {
//   static const phoneNumberScreen = '/phoneNumber';
//   static const otpScreen = '/otp';

//   static List<GetPage> routes = [
//     GetPage(name: phoneNumberScreen, page: () => PhoneNumberScreen()),
//     GetPage(name: otpScreen, page: () => OTPScreen()),
//   ];
// }


import 'package:get/get.dart';
import 'package:interview_task/Views/otp_screen.dart';
import 'package:interview_task/Views/phone_number_screen.dart';
import 'package:interview_task/Views/address_list_screen.dart';
import 'package:interview_task/Views/add_edit_address_screen.dart';

class AppRoutes {
  // Address Management Screens
  static const home = '/';
  static const addEditAddress = '/addEditAddress';

  // Phone Authentication Screens
  static const phoneNumberScreen = '/phoneNumber';
  static const otpScreen = '/otp';

  static List<GetPage> routes = [
    // Address Management Routes
    GetPage(name: home, page: () => AddressListScreen()),
    GetPage(name: addEditAddress, page: () => AddEditAddressScreen()),

    // Phone Authentication Routes
    GetPage(name: phoneNumberScreen, page: () => PhoneNumberScreen()),
    GetPage(name: otpScreen, page: () => OTPScreen()),
  ];
}
