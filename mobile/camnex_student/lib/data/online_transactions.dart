import '../models/online_transaction.dart';

final List<OnlineTransaction> onlineTransactions = [

  OnlineTransaction(
    title: "School Fee",
    amount: 3500,
    paymentMethod: "UPI",
    transactionId: "TXN1002458",
    referenceNo: "UPI784512369",
    date: "15 Jul 2026",
    time: "10:42 AM",
    status: "Successful",
    remarks: "Quarter 2 Tuition Fee",
  ),

  OnlineTransaction(
    title: "Smart Card Recharge",
    amount: 500,
    paymentMethod: "Debit Card",
    transactionId: "TXN1002459",
    referenceNo: "AXIS458963",
    date: "15 Jul 2026",
    time: "11:15 AM",
    status: "Successful",
    remarks: "Campus Smart Card Recharge",
  ),

  OnlineTransaction(
    title: "Transport Fee",
    amount: 500,
    paymentMethod: "Credit Card",
    transactionId: "TXN1002460",
    referenceNo: "HDFC458741",
    date: "15 Jul 2026",
    time: "12:20 PM",
    status: "Successful",
    remarks: "July Transport Fee",
  ),

  OnlineTransaction(
    title: "Library Fine",
    amount: 200,
    paymentMethod: "Net Banking",
    transactionId: "TXN1002461",
    referenceNo: "SBI458741",
    date: "15 Jul 2026",
    time: "02:35 PM",
    status: "Successful",
    remarks: "Late Return Fine",
  ),

];