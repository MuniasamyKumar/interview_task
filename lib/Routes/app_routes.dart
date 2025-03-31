import 'package:get/get.dart';
import 'package:interview_task/Views/otp_screen.dart';
import 'package:interview_task/Views/phone_number_screen.dart';
import 'package:interview_task/Views/address_list_screen.dart';
import 'package:interview_task/Views/add_edit_address_screen.dart';

class AppRoutes {
  static const phoneNumberScreen = '/';
  static const otpScreen = '/otp';
  static const home = '/home';
  static const addEditAddress = '/addEditAddress';

  static List<GetPage> routes = [
    GetPage(name: phoneNumberScreen, page: () => PhoneNumberScreen()),
    GetPage(name: otpScreen, page: () => OTPScreen()),
    GetPage(name: home, page: () => AddressListScreen()),
    GetPage(name: addEditAddress, page: () => AddEditAddressScreen()),
  ];
}
