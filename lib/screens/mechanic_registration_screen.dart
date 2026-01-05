import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mechanic_dashboard.dart';

class MechanicRegistrationScreen extends StatefulWidget {
  const MechanicRegistrationScreen({super.key});

  @override
  State<MechanicRegistrationScreen> createState() =>
      _MechanicRegistrationScreenState();
}

class _MechanicRegistrationScreenState
    extends State<MechanicRegistrationScreen> {
  final PageController _pageController = PageController();
  final ImagePicker _picker = ImagePicker();

  final Color primary = const Color(0xFFFB3300);

  int currentStep = 0;
  final int totalSteps = 4;
  bool showPassword = false;

  // ================= FIELDS =================
  File? profileImage;
  File? cnicFrontImage;
  File? cnicBackImage;

  String name = '';
  String phone = '';
  String password = '';
  String shopAddress = '';
  String homeAddress = '';
  String mechanicType = 'Bike Mechanic';
  String experience = '';
  String workingHours = '';

  // PASSWORD LIVE RULES
  bool hasNumber = false;
  bool hasSymbol = false;
  bool hasValidLength = false;

  // ================= IMAGE PICK =================
  Future<void> pickImage(String type) async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        if (type == 'profile') profileImage = File(img.path);
        if (type == 'cnicFront') cnicFrontImage = File(img.path);
        if (type == 'cnicBack') cnicBackImage = File(img.path);
      });
    }
  }

  // ================= VALIDATION LOGIC =================
  bool isValidPhone() => RegExp(r'^\+92\d{10}$').hasMatch(phone);

  void validatePassword(String value) {
    setState(() {
      hasNumber = RegExp(r'\d').hasMatch(value);
      hasSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
      hasValidLength = value.length >= 7 && value.length <= 12;
    });
  }

  // Step-wise Validation
  bool validateCurrentStep() {
    if (currentStep == 0) {
      if (name.trim().isEmpty || !isValidPhone() || !hasNumber || !hasSymbol || !hasValidLength) {
        showError("Please complete profile info and password rules.");
        return false;
      }
    } else if (currentStep == 1) {
      if (shopAddress.trim().isEmpty || homeAddress.trim().isEmpty) {
        showError("Shop and Home addresses are mandatory.");
        return false;
      }
    } else if (currentStep == 2) {
      if (experience.trim().isEmpty || workingHours.trim().isEmpty) {
        showError("Please provide experience and working hours.");
        return false;
      }
    } else if (currentStep == 3) {
      if (cnicFrontImage == null || cnicBackImage == null) {
        showError("Both CNIC Front and Back images are required.");
        return false;
      }
    }
    return true;
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  // ================= NAVIGATION =================
  void nextPage() {
    if (!validateCurrentStep()) return;

    if (currentStep < totalSteps - 1) {
      setState(() => currentStep++);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    } else {
      // Final Submission logic here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MechanicDashboardScreen()),
      );
    }
  }

  void previousPage() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    }
  }

  // ================= INPUT FIELD =================
  Widget input(
    String hint, {
    bool isPassword = false,
    TextInputType type = TextInputType.text,
    List<TextInputFormatter>? formatters,
    Widget? prefix,
    Function(String)? onChanged,
  }) {
    return TextField(
      keyboardType: type,
      obscureText: isPassword && !showPassword,
      inputFormatters: formatters,
      onChanged: onChanged,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off, color: primary),
                onPressed: () => setState(() => showPassword = !showPassword),
              )
            : null,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primary)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primary, width: 2)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (currentStep > 0)
                    IconButton(onPressed: previousPage, icon: Icon(Icons.arrow_back_ios_new, color: primary, size: 22)),
                  Expanded(
                    child: Text(_titles[currentStep], textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  IconButton(onPressed: showCloseDialog, icon: Icon(Icons.close, color: primary)),
                ],
              ),
            ),
            // PAGES
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [personalInfo(), locationInfo(), professionalInfo(), documentInfo()],
              ),
            ),
            // BOTTOM BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${currentStep + 1} of $totalSteps', style: GoogleFonts.poppins(fontSize: 12)),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: (currentStep + 1) / totalSteps,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(primary),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: nextPage,
                    child: Text(currentStep == totalSteps - 1 ? 'Submit' : 'Next',
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final List<String> _titles = ['Personal Information', 'Location Information', 'Professional Information', 'Documents'];

  // ================= STEPS UI =================

  Widget personalInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Upload Profile Picture', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('Visible to customers', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                ]),
              ),
              GestureDetector(
                onTap: () => pickImage('profile'),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
                  child: profileImage == null ? Icon(Icons.add_a_photo, color: primary) : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          input('Full Name', onChanged: (v) => name = v),
          const SizedBox(height: 12),
          input('Phone Number', type: TextInputType.phone, prefix: Padding(padding: const EdgeInsets.all(14), child: Text('+92', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))), onChanged: (v) => phone = '+92$v'),
          const SizedBox(height: 12),
          input('Password', isPassword: true, formatters: [LengthLimitingTextInputFormatter(12)], onChanged: (v) { password = v; validatePassword(v); }),
          const SizedBox(height: 12),
          _rule('Contains at least 1 number', hasNumber),
          _rule('Contains at least 1 symbol', hasSymbol),
          _rule('7–12 characters', hasValidLength),
        ],
      ),
    );
  }

  Widget locationInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          input('Shop Address (Mandatory)', onChanged: (v) => shopAddress = v),
          const SizedBox(height: 15),
          input('Home Address (Mandatory)', onChanged: (v) => homeAddress = v),
        ],
      ),
    );
  }

  Widget professionalInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: mechanicType,
            items: ['Bike Mechanic', 'Car Mechanic', 'Puncture Specialist'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => mechanicType = v!),
            decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primary))),
          ),
          const SizedBox(height: 12),
          input('Experience (Years)', type: TextInputType.number, onChanged: (v) => experience = v),
          const SizedBox(height: 12),
          input('Working Hours', onChanged: (v) => workingHours = v),
        ],
      ),
    );
  }

  Widget documentInfo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FRONT
          Text('CNIC Front Side (شناختی کارڈ کی سامنے کی تصویر)', textDirection: TextDirection.rtl, style: GoogleFonts.notoNastaliqUrdu(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => pickImage('cnicFront'),
            child: Container(
              height: 180, width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: primary), borderRadius: BorderRadius.circular(12), color: Colors.grey.shade50),
              child: cnicFrontImage == null ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_front, size: 40, color: primary), Text("Click to upload Front")]) : Image.file(cnicFrontImage!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 25),
          // BACK
          Text('CNIC Back Side (شناختی کارڈ کی پیچھے کی تصویر)', textDirection: TextDirection.rtl, style: GoogleFonts.notoNastaliqUrdu(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => pickImage('cnicBack'),
            child: Container(
              height: 180, width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: primary), borderRadius: BorderRadius.circular(12), color: Colors.grey.shade50),
              child: cnicBackImage == null ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_rear, size: 40, color: primary), Text("Click to upload Back")]) : Image.file(cnicBackImage!, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rule(String text, bool ok) {
    return Row(children: [Icon(ok ? Icons.check_circle : Icons.cancel, size: 16, color: ok ? Colors.green : Colors.grey), const SizedBox(width: 8), Text(text, style: GoogleFonts.poppins(color: ok ? Colors.green : Colors.grey, fontSize: 12))]);
  }

  void showCloseDialog() {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Exit?'),
      content: const Text('Progress will be lost.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
        ElevatedButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('Yes')),
      ],
    ));
  }
}