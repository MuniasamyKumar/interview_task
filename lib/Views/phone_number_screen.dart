import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_number/mobile_number.dart';
import '../Controllers/auth_controller.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<SimCard> _simCards = [];
  bool _isLoadingSims = false;

  @override
  void initState() {
    super.initState();
    _fetchSimCards();
  }

  Future<void> _fetchSimCards() async {
    setState(() => _isLoadingSims = true);

    try {
      bool? hasPermission = await MobileNumber.hasPhonePermission;
      if (hasPermission == false || hasPermission == null) {
        await MobileNumber.requestPhonePermission;
      }

      List<SimCard>? sims;
      try {
        sims = await MobileNumber.getSimCards;
      } catch (e) {
        print("Error getting SIM cards: $e");
      }

      if (sims == null || sims.isEmpty) {
        print("No SIM cards detected or permission denied");
        Get.snackbar(
          "No SIM Cards",
          "No SIM cards were detected on your device",
          backgroundColor: Colors.orange,
        );
        return;
      }

      setState(() => _simCards = sims!);

      print("Detected ${_simCards.length} SIM cards:");
      for (var sim in _simCards) {
        print("""
      SIM Slot ${sim.slotIndex}:
      - Number: ${sim.number}
      - Carrier: ${sim.carrierName}
      - Country ISO: ${sim.countryIso}
      - Display Name: ${sim.displayName}
      """);
      }
    } catch (e) {
      print("Error in _fetchSimCards: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch SIM details: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } finally {
      setState(() => _isLoadingSims = false);
    }
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
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildPhoneNumberField(),
                  const SizedBox(height: 20),
                  _buildRefreshSIMsButton(),
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
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
                icon:
                    _isLoadingSims
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.sim_card, color: Color(0xFF673AB7)),
                onPressed: _isLoadingSims ? null : _showSIMSelectionDialog,
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

  Widget _buildRefreshSIMsButton() {
    return OutlinedButton(
      onPressed: _fetchSimCards,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF673AB7),
        side: const BorderSide(color: Color(0xFF673AB7)),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.refresh, size: 20),
          const SizedBox(width: 8),
          Text(_isLoadingSims ? "Detecting SIMs..." : "Refresh SIM Cards"),
        ],
      ),
    );
  }

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: const Text(
        'Send OTP',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  void _showSIMSelectionDialog() {
    if (_simCards.isEmpty) {
      Get.snackbar(
        "No SIM Cards",
        "No SIM cards were detected on your device",
        backgroundColor: Colors.orange,
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text("Select SIM Card"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                _simCards.map((sim) {
                  String? rawNumber = sim.number;
                  String displayNumber = "No number detected";
                  String cleanNumber = "";

                  if (rawNumber != null && rawNumber.isNotEmpty) {
                    cleanNumber = rawNumber.replaceAll(RegExp(r'[^\d]'), '');

                    if (cleanNumber.startsWith('91') &&
                        cleanNumber.length > 10) {
                      cleanNumber = cleanNumber.substring(2);
                    } else if (cleanNumber.length > 10) {
                      cleanNumber = cleanNumber.substring(
                        cleanNumber.length - 10,
                      );
                    }

                    displayNumber =
                        cleanNumber.length == 10
                            ? cleanNumber
                            : "Invalid number ($rawNumber)";
                  }

                  return ListTile(
                    leading: const Icon(Icons.sim_card, color: Colors.purple),
                    title: Text("SIM Slot ${sim.slotIndex! + 1}"),
                    subtitle: Text(displayNumber),
                    trailing:
                        sim.carrierName != null
                            ? Chip(
                              label: Text(
                                sim.carrierName!,
                                style: const TextStyle(fontSize: 12),
                              ),
                            )
                            : null,
                    onTap: () {
                      if (cleanNumber.length == 10) {
                        phoneController.text = cleanNumber;
                        Get.back();
                      } else {
                        Get.snackbar(
                          "Invalid Number",
                          "Selected SIM doesn't have a valid 10-digit number",
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                  );
                }).toList(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
