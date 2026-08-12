class MonthlyAttendance {
  final String month;
  final int workingDays;
  final int presentDays;
  final int absentDays;
  final double percentage;

  /// P = Present
  /// A = Absent
  /// H = Holiday
  final List<String> calendar;

  const MonthlyAttendance({
    required this.month,
    required this.workingDays,
    required this.presentDays,
    required this.absentDays,
    required this.percentage,
    required this.calendar,
  });
}