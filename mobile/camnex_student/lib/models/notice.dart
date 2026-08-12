class NoticeModel {
  final String title;
  final String noticeId;
  final String category;
  final String date;
  final String description;
  bool isImportant;

  NoticeModel({
    required this.title,
    required this.noticeId,
    required this.category,
    required this.date,
    required this.description,
    this.isImportant = false,
  });
}