import 'dart:ui';
import 'package:flutter/material.dart';

import '../models/monthly_attendance.dart';

void showAttendanceDetails(
  BuildContext context,
  MonthlyAttendance month,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => const SizedBox(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6,
          sigmaY: 6,
        ),
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: .95,
              end: 1,
            ).animate(animation),
            child: Center(
              child: Material(
                color: Colors.white,
                elevation: 15,
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: 820,
                  height: 560,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [

                        Text(
                          "${month.month} Attendance",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 25),

                        Expanded(
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              // LEFT PANEL

 SizedBox(
  width: 230,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      _row(
        "Working Days",
        "${month.workingDays}",
      ),

      _row(
        "Present",
        "${month.presentDays}",
      ),

      _row(
        "Absent",
        "${month.absentDays}",
      ),

      _row(
        "Attendance",
        "${month.percentage.toStringAsFixed(0)}%",
      ),

      const SizedBox(height: 12),

      const Divider(),

      const SizedBox(height: 12),

      const _Legend(
        Colors.green,
        "Present",
      ),

      const SizedBox(height: 10),

      const _Legend(
        Colors.red,
        "Absent",
      ),

      const SizedBox(height: 10),

      const _Legend(
        Colors.grey,
        "Holiday",
      ),
    ],
  ),
),

                              const SizedBox(width: 25),

                              // RIGHT PANEL

                              Expanded(
                                child: Column(
                                  children: [

                                    const Text(
                                      "Attendance Calendar",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("M"),
                                        Text("T"),
                                        Text("W"),
                                        Text("T"),
                                        Text("F"),
                                        Text("S"),
                                        Text("S"),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    Expanded(
                                      child: _calendar(month),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context),
                              child: const Text("Close"),
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
        ),
      );
    },
  );
}
Widget _calendar(MonthlyAttendance month) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: month.calendar.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 7,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      childAspectRatio: 1,
    ),
    itemBuilder: (context, index) {
      final status = month.calendar[index];

      Color color;

      switch (status) {
        case "P":
          color = Colors.green;
          break;

        case "A":
          color = Colors.red;
          break;

        default:
          color = Colors.grey;
      }

      return Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          "${index + 1}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      );
    },
  );
}
Widget _row(
  String title,
  String value,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 14,
    ),
    decoration: BoxDecoration(
      color: const Color(0xffF7F9FC),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),

      ],
    ),
  );
}
class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend(
    this.color,
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}