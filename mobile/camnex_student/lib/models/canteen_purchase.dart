class CanteenPurchase {
  final String itemName;
  final String purchaseDate;
  final int amount;
  final String paymentMode;
  final String status;
  final String transactionId;

  CanteenPurchase({
    required this.itemName,
    required this.purchaseDate,
    required this.amount,
    required this.paymentMode,
    required this.status,
    required this.transactionId,
  });
}