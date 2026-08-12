import 'package:flutter/material.dart';
import 'reset_password_screen.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

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
                    "OTP Verification",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Enter OTP sent to your email",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const TextField(
                    keyboardType:
                        TextInputType.number,
                    maxLength: 6,
                    decoration:
                        InputDecoration(
                      labelText:
                          "6 Digit OTP",
                      prefixIcon:
                          Icon(Icons.lock),
                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment:
                        Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO:
                        // Call Resend OTP API
                      },
                      child: const Text(
                        "Resend OTP",
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                                0xFFFF6B00),
                      ),

                      onPressed: () {
                        // TODO:
                        // Verify OTP API

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ResetPasswordScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        "VERIFY OTP",
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
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
}