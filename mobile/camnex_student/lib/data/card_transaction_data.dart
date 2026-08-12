import '../models/card_transaction.dart';

final List<CardTransaction> cardTransactions = [

  CardTransaction(
    title: "Recharge",
    subtitle: "Online Payment",
    amount: 500,
    isCredit: true,
    date: DateTime(2025, 7, 12),
  ),

  CardTransaction(
    title: "Canteen",
    subtitle: "Lunch",
    amount: 80,
    isCredit: false,
    date: DateTime(2025, 7, 13),
  ),

  CardTransaction(
    title: "Library",
    subtitle: "Late Fine",
    amount: 20,
    isCredit: false,
    date: DateTime(2025, 7, 14),
  ),

];