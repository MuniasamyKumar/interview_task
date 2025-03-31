import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../Controllers/auth_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with CodeAutoFill {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RxBool isOtpFilled = false.obs;

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void codeUpdated() {
    setState(() {
      otpController.text = code ?? "";
    });
    isOtpFilled.value = otpController.text.length == 6;
  }

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
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF673AB7),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF673AB7).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.security_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'OTP Verification',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  PinFieldAutoFill(
                    controller: otpController,
                    codeLength: 6,
                    decoration: BoxLooseDecoration(
                      strokeColorBuilder: FixedColorBuilder(Colors.grey),
                      bgColorBuilder: FixedColorBuilder(Colors.white),
                    ),
                    currentCode: otpController.text,
                    onCodeChanged: (code) {
                      isOtpFilled.value = (code?.length == 6);
                    },
                  ),

                  const SizedBox(height: 20),

                  Obx(
                    () => ElevatedButton(
                      onPressed:
                          isOtpFilled.value
                              ? () {
                                if (_formKey.currentState!.validate()) {
                                  authController.verifyOTP(otpController.text);
                                }
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF673AB7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
}
