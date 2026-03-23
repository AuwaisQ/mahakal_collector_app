// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:collectorapp/features/login/controller/auth_controller.dart';
// import '../collector/home/collectordashboard_screen.dart';
// import '../sdm/home/sdmdashboard_screen.dart';
//
// class OtpVerificationScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   const OtpVerificationScreen({
//     super.key,
//     required this.phoneNumber,
//   });
//
//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }
//
// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   bool _isLoading = false;
//   int _resendTimer = 60;
//   bool _canResend = false;
//   Timer? _timer;
//   String _errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//     _checkClipboard();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     //_otpController.dispose();
//     super.dispose();
//   }
//
//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_resendTimer > 0) {
//         setState(() {
//           _resendTimer--;
//         });
//       } else {
//         setState(() {
//           _canResend = true;
//         });
//         timer.cancel();
//       }
//     });
//   }
//
//   Future<void> _checkClipboard() async {
//     try {
//       final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
//       if (clipboardData != null && clipboardData.text != null) {
//         String text = clipboardData.text!.trim();
//         if (text.length == 6 && _isNumeric(text)) {
//           if (text.contains(RegExp(r'^\d{6}$'))) {
//             _otpController.text = text;
//           }
//         }
//       }
//     } catch (e) {
//       print('Error checking clipboard: $e');
//     }
//   }
//
//   bool _isNumeric(String s) {
//     return double.tryParse(s) != null;
//   }
//
//   Future<void> _verifyOTP() async {
//     final otp = _otpController.text.trim();
//
//     if (otp.length != 6) {
//       _showError('Please enter 6-digit OTP');
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     final authController = Provider.of<AuthController>(context, listen: false);
//
//     final result = await authController.verifyOTP(otp);
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     if (result['success']) {
//       // Show success message from controller
//       _showSuccess(result['message'] ?? 'Verification successful');
//
//       String vendorType = authController.loginResponse?.type ?? '';
//
//       // Navigate to home screen
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (_) => _getDashboardScreen(vendorType),
//         ),
//             (route) => false,
//       );
//
//     } else {
//       // Show error message from controller
//       _showError(result['message'] ?? 'Invalid OTP. Please try again.');
//
//       // Clear OTP field on error
//       _otpController.clear();
//     }
//   }
//
//   Widget _getDashboardScreen(String vendorType) {
//
//     print("Login Vendore Type:${vendorType.toUpperCase()}");
//
//     switch (vendorType.toUpperCase()) {
//       case "COLLECTOR":
//         return const CollectorDashboardScreen();
//
//       case "SDM":
//         return const SDMDashboardScreen(); //  apni SDM screen
//
//       default:
//         return const CollectorDashboardScreen(); // fallback
//     }
//   }
//
//   Future<void> _resendOTP() async {
//     if (!_canResend) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });
//
//     final authController = Provider.of<AuthController>(context, listen: false);
//
//     // Use the loginWithPhone method which checks registration first
//     final result = await authController.loginWithPhone('+91${widget.phoneNumber}');
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     if (result['success'] && result['registered'] == true) {
//       _showSuccess('OTP resent successfully');
//
//       // Reset timer
//       setState(() {
//         _resendTimer = 60;
//         _canResend = false;
//       });
//
//       _startTimer();
//
//       // Clear previous OTP
//       _otpController.clear();
//     } else {
//       _showError(result['message'] ?? 'Failed to resend OTP');
//
//       // If user is not registered, go back to login
//       if (result['registered'] == false) {
//         Future.delayed(Duration(seconds: 2), () {
//           Navigator.pop(context);
//         });
//       }
//     }
//   }
//
//   void _showError(String message) {
//     setState(() {
//       _errorMessage = message;
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
//
//   void _showSuccess(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   String _formatPhoneNumber(String phone) {
//     if (phone.length == 10) {
//       return '+91 ${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6)}';
//     }
//     return phone;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepOrange,
//       body: SafeArea(
//         child: Column(
//           children: [
//
//             // Top Orange Section
//             Container(
//               height: MediaQuery.of(context).size.height * 0.25,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.deepOrange.shade700,
//                     Colors.deepOrange.shade400,
//                   ],
//                 ),
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(40),
//                   bottomRight: Radius.circular(40),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.deepOrange.withOpacity(0.3),
//                     blurRadius: 20,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   // Decorative circles
//                   Positioned(
//                     top: -30,
//                     right: -20,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.deepOrange.shade300.withOpacity(0.3),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: -40,
//                     left: -30,
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.deepOrange.shade200.withOpacity(0.2),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//
//                   // Header content
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Back button
//                         GestureDetector(
//                           onTap: () => Navigator.pop(context),
//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.arrow_back_ios_new_rounded,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//
//                         const Text(
//                           "OTP Verification",
//                           style: TextStyle(
//                             fontSize: 22,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           "Enter the 6-digit code sent to your number",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.white.withOpacity(0.9),
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Bottom White Section
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       blurRadius: 30,
//                       spreadRadius: 5,
//                       offset: const Offset(0, -5),
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Verification Title
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(
//                                 Icons.verified,
//                                 color: Colors.deepOrange,
//                                 size: 28,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 "Enter OTP",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   color: Colors.deepOrange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//
//                           // Phone Number Display
//                           Container(
//                             margin: const EdgeInsets.only(top: 8),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: "✓ Confirmation code sent to ",
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey.shade700,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: _formatPhoneNumber(widget.phoneNumber),
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.deepOrange.shade600,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   "Please enter the 6-digit code below",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey.shade600,
//                                     fontStyle: FontStyle.italic,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//
//                       // Error message
//                       if (_errorMessage.isNotEmpty)
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           margin: const EdgeInsets.only(bottom: 16),
//                           decoration: BoxDecoration(
//                             color: Colors.red.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.red.shade100),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Text(
//                                   _errorMessage,
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.red.shade700,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                       // OTP Input Section
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.grey.shade200,
//                             width: 1.5,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.05),
//                               blurRadius: 15,
//                               spreadRadius: 2,
//                               offset: const Offset(0, 5),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "ENTER 6-DIGIT OTP",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.deepOrange.shade600,
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 0.8,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//
//                             // Pin Code Fields
//                             PinCodeTextField(
//                               appContext: context,
//                               length: 6,
//                               controller: _otpController,
//                               animationType: AnimationType.fade,
//                               pinTheme: PinTheme(
//                                 shape: PinCodeFieldShape.box,
//                                 borderRadius: BorderRadius.circular(12),
//                                 fieldHeight: 56,
//                                 fieldWidth: 45,
//                                 activeFillColor: Colors.white,
//                                 selectedFillColor: Colors.deepOrange.shade50,
//                                 inactiveFillColor: Colors.white,
//                                 activeColor: Colors.deepOrange.shade400,
//                                 selectedColor: Colors.deepOrange.shade600,
//                                 inactiveColor: _errorMessage.isNotEmpty
//                                     ? Colors.red.shade300
//                                     : Colors.grey.shade300,
//                                 errorBorderColor: Colors.red,
//                               ),
//                               textStyle: const TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepOrange,
//                               ),
//                               enableActiveFill: true,
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                               onCompleted: (value) {
//                                 _verifyOTP();
//                               },
//                               onChanged: (value) {
//                                 setState(() {
//                                   _errorMessage = '';
//                                 });
//                               },
//                               beforeTextPaste: (text) {
//                                 // Allow paste
//                                 return true;
//                               },
//                             ),
//                             const SizedBox(height: 10),
//
//                             // Timer and Resend OTP
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.access_time_rounded,
//                                       size: 16,
//                                       color: _resendTimer <= 10 ? Colors.red : Colors.grey,
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       '00:${_resendTimer.toString().padLeft(2, '0')}',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: _resendTimer <= 10 ? Colors.red : Colors.deepOrange,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 GestureDetector(
//                                   onTap: _canResend ? _resendOTP : null,
//                                   child: Text(
//                                     "Resend OTP",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: _canResend
//                                           ? Colors.deepOrange.shade600
//                                           : Colors.grey.shade500,
//                                       fontWeight: FontWeight.w600,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Note about OTP
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: Colors.blue.shade100,
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.info_outline_rounded,
//                               color: Colors.blue.shade600,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Text(
//                                 "The OTP will expire in 1 minute. Enter it before the timer runs out.",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.blue.shade700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Verify Button with gradient
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.deepOrange,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 0,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: _isLoading ? null : _verifyOTP,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 colors: [
//                                   Colors.deepOrange.shade700,
//                                   Colors.deepOrange.shade400,
//                                 ],
//                               ),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Center(
//                               child: _isLoading
//                                   ? SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                                   : const Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Verify OTP",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                       letterSpacing: 0.5,
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Icon(
//                                     Icons.verified_rounded,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                         margin: const EdgeInsets.only(top: 5),
//                         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // Upper row with text
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Icon(
//                                 //   Icons.security_rounded,
//                                 //   size: 14,
//                                 //   color: Colors.green.shade500,
//                                 // ),
//                                 // const SizedBox(width: 8),
//                                 const Text(
//                                   "Secured by ",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8), // space between text and logo
//                             // Logo below
//                             Image.asset(
//                               "assets/images/mahakalLogo.gif",
//                               height: 35, // adjust height as needed
//                               fit: BoxFit.contain,
//                               gaplessPlayback: true,
//                             ),
//                           ],
//                         ),
//                       )
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
