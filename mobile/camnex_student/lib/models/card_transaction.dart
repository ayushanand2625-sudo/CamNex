class CardTransaction {
  final String title;
  final String subtitle;
  final double amount;
  final bool isCredit;
  final DateTime date;

  const CardTransaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.date,
  });
}