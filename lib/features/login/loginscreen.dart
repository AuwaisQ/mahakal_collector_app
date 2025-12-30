// import 'package:collectorapp/features/login/controller/auth_controller.dart';
// import 'package:collectorapp/features/otpverify/otpverify.dart';
// import 'package:flutter/material.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:provider/provider.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   final TextEditingController _phoneController = TextEditingController();
//
//   String _countryCode = '+91';
//   bool _isLoading = false;
//
//   Future<void> _sendOTP() async {
//     if (_phoneController.text.isEmpty || _phoneController.text.length != 10) {
//       _showSnackBar('Please enter valid 10-digit mobile number');
//       return;
//     }
//
//     setState(() => _isLoading = true);
//
//     final authController = Provider.of<AuthController>(context, listen: false);
//     String phoneNumber = _phoneController.text.trim();
//
//     Map<String, dynamic> result;
//
//       // Use new API + Firebase OTP
//     result = await authController.loginWithPhone('+91$phoneNumber');
//
//     print("Success: ${result['success']}");
//     print("Registered:${result['registered']}");
//     print("${result['message']}");
//
//     setState(() => _isLoading = false);
//
//     if (result['success']) {
//       // Check if user is registered
//       if (result['registered'] == true) {
//
//         // Navigate to OTP screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpVerificationScreen(
//               phoneNumber: phoneNumber,
//               //token: result['token'], // Pass token if available
//             ),
//           ),
//         );
//       } else {
//         // User not registered
//         _showSnackBar(result['message']);
//       }
//     } else {
//       // Show error message
//       _showSnackBar(result['message']);
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepOrange,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Orange Section with gradient and wave effect
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
//                   // Welcome content
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: const Icon(
//                             Icons.lock_open_rounded,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           "Welcome Back",
//                           style: TextStyle(
//                             fontSize: 22,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           "Login to continue your journey",
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
//                 padding: const EdgeInsets.all(25),
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
//                   child:
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       // Login Title
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: const [
//                               Icon(
//                                 Icons.login,
//                                 color: Colors.deepOrange,
//                                 size: 28,
//                               ),
//                               SizedBox(width: 8),
//                               Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   color: Colors.deepOrange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//
//                           // Subtitle
//                           const Text(
//                             "Login with! your registered mobile number",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//
//                       // Phone Input Card
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
//                               "PHONE NUMBER",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.deepOrange.shade600,
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 0.8,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//
//                             // Phone Input Row
//                             Row(
//                               children: [
//
//                                 Container(
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey.shade300),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: CountryCodePicker(
//                                     onChanged: (code) {
//                                       _countryCode = code.dialCode ?? '+91';
//                                     },
//                                     initialSelection: 'IN',
//                                     favorite: const ['+91', 'IN'],
//                                     showCountryOnly: false,
//                                     showOnlyCountryWhenClosed: false,
//                                     alignLeft: false,
//                                   ),
//                                 ),
//
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Container(
//                                     height: 50,
//                                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.grey.shade300),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: TextField(
//                                       keyboardType: TextInputType.phone,
//                                       controller: _phoneController,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                       ),
//                                       decoration: const InputDecoration(
//                                         hintText: "Mobile Number",
//                                         hintStyle: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                         ),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 38),
//
//                       // Terms and Conditions
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text.rich(
//                           TextSpan(
//                             text: "By continuing, you agree to our ",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey.shade600,
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: "Terms of Service",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.deepOrange.shade600,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               const TextSpan(text: " and "),
//                               TextSpan(
//                                 text: "Privacy Policy",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.deepOrange.shade600,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const SizedBox(height: 38),
//
//                       // Verify Button with gradient
//                       SizedBox(
//                         width: double.infinity,
//                         height: 56,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.deepOrange,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 0,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: _isLoading ? null : _sendOTP,
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
//                             child:  Center(
//                               child: _isLoading
//                                   ? CircularProgressIndicator(color: Colors.white)
//                                   : Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Verify & Continue",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                       letterSpacing: 0.5,
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Icon(
//                                     Icons.arrow_forward_rounded,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//
//                       // Divider with "or"
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Divider(
//                               color: Colors.grey.shade300,
//                               thickness: 1,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Icon(Icons.abc,color: Colors.grey,),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               color: Colors.grey.shade300,
//                               thickness: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 15),
//
//                       // Info Text
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 7.0),
//                         child: Text(
//                           'Note: Your account must be pre-registered by admin. '
//                               'If facing issues, contact support.',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey.shade600,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//
//                       // Alternative Options
//                       Container(
//                         margin: EdgeInsets.only(top: 15),
//                         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.security_rounded,
//                               size: 14,
//                               color: Colors.green.shade500,
//                             ),
//                             SizedBox(width: 8),
//                             Text(
//                               "Secured by ",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             Text(
//                               "MAHAKAL",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.deepOrange.shade600,
//                                 fontWeight: FontWeight.w700,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                             Text(
//                               ".com",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade600,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
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

import 'package:collectorapp/features/login/controller/auth_controller.dart';
import 'package:collectorapp/features/otpverify/otpverify.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _phoneController = TextEditingController();
  String _countryCode = '+91';
  bool _isLoading = false;

  Future<void> _sendOTP() async {
    if (_phoneController.text.isEmpty || _phoneController.text.length != 10) {
      _showSnackBar('Please enter valid 10-digit mobile number');
      return;
    }

    setState(() => _isLoading = true);

    final authController = Provider.of<AuthController>(context, listen: false);
    String phoneNumber = _phoneController.text.trim();

    // Use API + Firebase OTP
    final result = await authController.loginWithPhone('+91$phoneNumber');

    print("Success: ${result['success']}");
    print("Registered: ${result['registered']}");
    print("Message: ${result['message']}");

    setState(() => _isLoading = false);

    if (result['success']) {
      // Check if user is registered
      if (result['registered'] == true) {
        // Navigate to OTP screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              phoneNumber: phoneNumber,
            ),
          ),
        );
      } else {
        // User not registered
        _showSnackBar(result['message'] ?? 'User not registered');
      }
    } else {
      // Show error message
      _showSnackBar(result['message'] ?? 'Failed to send OTP');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains('success') || message.contains('Success')
            ? Colors.green
            : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: Column(
          children: [
            // Top Orange Section with gradient and wave effect
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepOrange.shade700,
                    Colors.deepOrange.shade400,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -30,
                    right: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade300.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    left: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade200.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // Welcome content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.lock_open_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Login to continue your journey",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom White Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Login Title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.login,
                                color: Colors.deepOrange,
                                size: 28,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Subtitle
                          const Text(
                            "Login with your registered mobile number",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),

                      // Phone Input Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.05),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PHONE NUMBER",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.deepOrange.shade600,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Phone Input Row
                            Row(
                              children: [

                                SizedBox(
                                  width: 60,
                                  height: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: CountryCodePicker(
                                      onChanged: (code) {
                                        _countryCode = code.dialCode ?? '+91';
                                      },
                                      initialSelection: 'IN',
                                      favorite: const ['+91', 'IN'],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      showFlag: false, // 🔥 FLAG REMOVE
                                      alignLeft: false,
                                      padding: EdgeInsets.zero, // extra space bhi hat jayega
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      controller: _phoneController,
                                      maxLength: 10,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "Mobile Number",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        counterText: "",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 38),

                      // Terms and Conditions
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text.rich(
                          TextSpan(
                            text: "By continuing, you agree to our ",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms of Service",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepOrange.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepOrange.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Verify Button with gradient
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: _isLoading ? null : _sendOTP,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.deepOrange.shade700,
                                  Colors.deepOrange.shade400,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: _isLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Verify & Continue",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Info Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Text(
                          'Note: Your account must be pre-registered by admin. '
                              'If facing issues, contact support.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Upper row with text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(
                                //   Icons.security_rounded,
                                //   size: 14,
                                //   color: Colors.green.shade500,
                                // ),
                                // const SizedBox(width: 8),
                                const Text(
                                  "Powered by ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8), // space between text and logo
                            // Logo below
                            Image.asset(
                              "assets/images/mahakalLogo.gif",
                              height: 35, // adjust height as needed
                              fit: BoxFit.contain,
                              gaplessPlayback: true,
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}