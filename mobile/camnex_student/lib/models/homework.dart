class Homework {
  final String subject;
  final String teacher;
  final String title;
  final String description;
  final String assignedDate;
  final String dueDate;
  final String submissionMode;

  String status;

  final List<String> attachments;
  final String teacherRemarks;
  final String marksAwarded;
  final String reviewedOn;

  Homework({
    required this.subject,
    required this.teacher,
    required this.title,
    required this.description,
    required this.assignedDate,
    required this.dueDate,
    required this.submissionMode,
    required this.status,
    required this.attachments,
    required this.teacherRemarks,
    required this.marksAwarded,
    required this.reviewedOn,
  });

  Homework copy() {
    return Homework(
      subject: subject,
      teacher: teacher,
      title: title,
      description: description,
      assignedDate: assignedDate,
      dueDate: dueDate,
      submissionMode: submissionMode,
      status: status,
      attachments: List<String>.from(attachments),
      teacherRemarks: teacherRemarks,
      marksAwarded: marksAwarded,
      reviewedOn: reviewedOn,
    );
  }
}