class TeacherRemark {
  final String teacherName;
  final String subject;
  final String date;
  final String title;
  final String remark;
  final String suggestion;
  final String teacherImage;
  final List<String> attachments;

  const TeacherRemark({
    required this.teacherName,
    required this.subject,
    required this.date,
    required this.title,
    required this.remark,
    required this.suggestion,
    required this.teacherImage,
    required this.attachments,
  });
}