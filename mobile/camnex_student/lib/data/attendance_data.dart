import '../models/monthly_attendance.dart';

final List<MonthlyAttendance> monthlyAttendance = [

  MonthlyAttendance(
    month: "April",
    workingDays: 22,
    presentDays: 21,
    absentDays: 1,
    percentage: 95,
    calendar: [
      "P","P","P","A","P","H","H",
      "P","P","P","P","P","H","H",
      "P","P","P","P","P","H","H",
      "P","P"
    ],
  ),

  MonthlyAttendance(
    month: "May",
    workingDays: 25,
    presentDays: 24,
    absentDays: 1,
    percentage: 98,
    calendar: [
      "P","P","P","P","P","H","H",
      "P","P","P","P","P","H","H",
      "P","P","P","P","P","H","H",
      "P","P","P","P"
    ],
  ),

  MonthlyAttendance(
    month: "June",
    workingDays: 24,
    presentDays: 24,
    absentDays: 0,
    percentage: 100,
    calendar: [
      "P","P","P","P","P","H","H",
      "P","P","P","P","P","H","H",
      "P","P","P","P","P","H","H",
      "P","P","P"
    ],
  ),

  MonthlyAttendance(
    month: "July",
    workingDays: 25,
    presentDays: 23,
    absentDays: 2,
    percentage: 92,
    calendar: [
      "P","P","P","A","P","H","H",
      "P","P","P","P","P","H","H",
      "P","A","P","P","P","H","H",
      "P","P","P","P"
    ],
  ),

];