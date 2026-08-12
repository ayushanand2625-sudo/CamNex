import 'package:flutter/material.dart';

import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 246, 237),

      body: Center(
        child: SizedBox(
          width: 450,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(30),

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/camnex_logo.png",
                    height: 100,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Enter your registered email address to receive an OTP.",
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const TextField(
                    decoration:
                        InputDecoration(
                      labelText:
                          "Email Address",
                      prefixIcon:
                          Icon(
                        Icons.email,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            const Color(
                          0xFFFF6B00,
                        ),
                      ),

                      onPressed: () {
                        // TODO:
                        // 1. Call Send OTP API
                        // 2. Validate Email
                        // 3. Navigate to OTP Screen

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const OTPVerificationScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        "SEND OTP",
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context);
                    },
                    child: const Text(
                      "Back to Login",
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
}