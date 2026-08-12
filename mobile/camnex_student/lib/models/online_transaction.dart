class OnlineTransaction {
  final String title;
  final double amount;
  final String paymentMethod;
  final String transactionId;
  final String referenceNo;
  final String date;
  final String time;
  final String status;
  final String remarks;

  const OnlineTransaction({
    required this.title,
    required this.amount,
    required this.paymentMethod,
    required this.transactionId,
    required this.referenceNo,
    required this.date,
    required this.time,
    required this.status,
    required this.remarks,
  });
}