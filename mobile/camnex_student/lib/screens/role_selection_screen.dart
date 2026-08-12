import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'parent_login_screen.dart';
import 'teacher_login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: const Color(0xFFFFF7F0),

      body: Center(
        child: Container(
          width: 540,
          padding: const EdgeInsets.symmetric(
  horizontal: 45,
  vertical: 50,
),

          decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(30),
  border: Border.all(
    color: const Color(0xFFEAECEF),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.orange.withValues(alpha: 0.08),
      blurRadius: 35,
      offset: const Offset(0, 15),
    ),
  ],
),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              Image.asset(
                "assets/images/camnex_logo.png",
                height: 120,
              ),

              const SizedBox(height: 30),

              const Text(
                "Select Your Role",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFF6B00),
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  },
                  child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    Icon(Icons.school),
    SizedBox(width: 10),
    Text("Student"),
  ],
),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
  width: double.infinity,
  height: 60,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF6B00),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ParentLoginScreen(),
        ),
      );
    },
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.family_restroom),
        SizedBox(width: 10),
        Text("Parent"),
      ],
    ),
  ),
),
const SizedBox(height: 20),

SizedBox(
  width: double.infinity,
  height: 60,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF6B00),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TeacherLoginScreen(),
        ),
      );
    },
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.badge),
        SizedBox(width: 10),
        Text("Teacher"),
      ],
    ),
  ),
),

const SizedBox(height: 35),

const Divider(),

const SizedBox(height: 15),

const Text(
  "© 2026 CamNex",
  style: TextStyle(
    color: Colors.grey,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  ),
),

const SizedBox(height: 5),

const Text(
  "School Management System",
  style: TextStyle(
    color: Colors.grey,
    fontSize: 12,
  ),
),

               
            ],
            
          ),
          
        ),
      ),
    );
  }
}