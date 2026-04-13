import 'package:fin_wise/core/constant.dart';
class AirtimeApiModel{

  final String status;
  final String reference ;
  final DateTime date;
  final String narration;
  final NumbersModel message;

  AirtimeApiModel({
    required this.status,
    required this.date,
    required this.narration,
    required this.reference,
    required this.message,
});

}


class NumbersModel{

  final ServiceProvider provider;
  final String number;
  final double amount;

  NumbersModel({
    required this.provider,
    required this.number,
    required this.amount,
});

}