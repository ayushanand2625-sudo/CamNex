import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentForgotPasswordScreen extends StatelessWidget {
  const StudentForgotPasswordScreen({super.key});

  static const String supportEmail = "camdesk326@gmail.com";

  static const String emailFormat = '''
Dear CamDesk Support Team,

I would like to request a password reset for my student account.

Student Name :
School Name :
Admission Number :
Class :
Section :
Date of Birth :
Parent / Guardian Name :
Registered Mobile Number :
Registered Email Address :

Thank you.

Regards,
<Student Name>
''';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F0),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: width > 850 ? 800 : width,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Icon
                    const Center(
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: Color(0xFFFFF2E8),
                        child: Icon(
                          Icons.lock_reset,
                          size: 40,
                          color: Color(0xFFFF6B00),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    const Center(
                      child: Text(
                        "Student Password Recovery",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF172033),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Center(
                      child: Text(
                        "Forgot your password?\nPlease send an email using the format below.\nAfter verification, your password will be mailed to your registered email address.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    // Email
                    const Text(
                      "Send Email To",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4EA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Color(0xFFFF6B00),
                          ),
                          SizedBox(width: 12),
                          Text(
                            supportEmail,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Subject
                    const Text(
                      "Email Subject",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Student Password Reset Request",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Format
                    const Text(
                      "Email Format",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: const SelectableText(
                        emailFormat,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Information
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.shade200,
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Icon(
                            Icons.info_outline,
                            color: Color(0xFFFF6B00),
                          ),

                          SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              "Please provide accurate information for verification. Once verified by your school, your password or reset instructions will be sent to your registered email address. Verification may take 24–48 working hours.",
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Buttons
                    Row(
                      children: [

                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF6B00),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                Clipboard.setData(
                                  const ClipboardData(
                                    text: emailFormat,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Email format copied successfully.",
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy),
                              label: const Text(
                                "Copy Email Format",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    const Color(0xFFFF6B00),
                                side: const BorderSide(
                                  color: Color(0xFFFF6B00),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Back to Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Center(
                      child: Text(
                        "Need additional help? Please contact your school administrator.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}