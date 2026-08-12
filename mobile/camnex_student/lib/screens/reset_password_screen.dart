import 'package:flutter/material.dart';

import 'parent_login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final TextEditingController
      passwordController =
      TextEditingController();

  final TextEditingController
      confirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(
              255, 255, 246, 237),

      body: Center(
        child: SizedBox(
          width: 450,

          child: Card(
            elevation: 10,

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

                  const SizedBox(
                      height: 20),

                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 15),

                  const Text(
                    "Create a new password",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(
                      height: 30),

                  TextField(
                    controller:
                        passwordController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "New Password",
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  TextField(
                    controller:
                        confirmController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Confirm Password",
                      prefixIcon: Icon(
                        Icons.lock_outline,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 30),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,
                    child:
                        ElevatedButton(
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            Colors.orange,
                      ),
                      onPressed: () {
                        if (passwordController
                                .text
                                .isEmpty ||
                            confirmController
                                .text
                                .isEmpty) {
                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please fill all fields",
                              ),
                            ),
                          );
                          return;
                        }

                        if (passwordController
                                .text !=
                            confirmController
                                .text) {
                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Passwords do not match",
                              ),
                            ),
                          );
                          return;
                        }

                        // CALL RESET PASSWORD API HERE

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Password Reset Successfully",
                            ),
                          ),
                        );

                        Navigator
                            .pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ParentLoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "RESET PASSWORD",
                        style:
                            TextStyle(
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