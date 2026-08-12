import 'package:flutter/material.dart';

import 'forgot_password_screen.dart';
import 'parent_dashboard_screen.dart';

class ParentLoginScreen extends StatelessWidget {
  const ParentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 246, 237),

      body: Center(
        child: SizedBox(
          width: width > 500 ? 450 : width * 0.9,

          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(30),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/camnex_logo.png",
                    height: 100,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Parent Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      prefixIcon:
                          Icon(Icons.email),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon:
                          Icon(Icons.lock),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment:
                        Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
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
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  15),
                        ),
                      ),

                      onPressed: () {
                        Navigator
                            .pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ParentDashboardScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Powering the Next Campus Generation",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
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