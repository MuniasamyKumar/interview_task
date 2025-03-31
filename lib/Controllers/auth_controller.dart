import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/Model/user_model.dart';
import 'package:interview_task/Routes/app_routes.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  var user = Rx<UserModel?>(null);

  @override
  void onReady() {
    super.onReady();
    user.value = _getUser();

     if (user.value == null) {
      Get.offAllNamed(AppRoutes.phoneNumberScreen);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  UserModel? _getUser() {
    User? firebaseUser = _auth.currentUser;
    return firebaseUser != null
        ? UserModel(uid: firebaseUser.uid, phoneNumber: firebaseUser.phoneNumber)
        : null;
  }

  void verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        user.value = _getUser();
        Get.snackbar("Success", "User signed in automatically!",colorText: Colors.white,backgroundColor: Colors.green);
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Error", e.message ?? "Verification failed",colorText: Colors.white,backgroundColor: Colors.red);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        Get.toNamed(AppRoutes.otpScreen);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      user.value = _getUser();
      Get.snackbar("Success", "User signed in successfully",colorText: Colors.white,backgroundColor: Colors.green);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP",colorText: Colors.white,backgroundColor: Colors.red);
    }
  }

  void signOut() async {
    await _auth.signOut();
    user.value = null;
    Get.snackbar("Logged Out", "User signed out successfully", colorText: Colors.white,backgroundColor: Colors.green);
  }
}
