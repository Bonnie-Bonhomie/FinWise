// Model

import '../../core/constant.dart';

class TransactionModel {
  final String id;
  final String title;
  DateTime time;
  final Categories category;
  final double amount;
  final bool isIncome;
  final TransactionStatus status;

  TransactionModel({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    required this.amount,
    required this.isIncome,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      title: json['title'],
      time: json['time'],
      category: json['category'],
      amount: json['amount'],
      isIncome: json['isIncome'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap(TransactionModel card){
    return {
      'id': card.id,
      'title': card.title,
      'time': card.time,
      'category': card.category,
      'amount': card.amount,
      'isIncome': card.isIncome,
      'status': card.status,
    };
  }
}
