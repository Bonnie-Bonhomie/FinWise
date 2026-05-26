// Model

import '../../core/constant.dart';

class TransactionModel {
  final int transactId;
  final String modelableType;
  final String modelableId;
  String referenceId;
  String productRef;
  final String purchaseAt;
  Categories? category;
  final double amount;
  final String phoneNo;
  int? status;
  final TransactionStatus apiStatus;
  String? message;
  String? meterNo;
  String? token;
  String? serviceType;
  String? pin;

  TransactionModel({
    required this.transactId,
    required this.modelableType,
    required this.modelableId,
    required this.referenceId,
    required this.productRef,
    required this.purchaseAt,
    this.category,
    required this.amount,
    required this.apiStatus,
    required this.phoneNo,
    this.status,
    this.message,
    this.meterNo,
    this.token,
    this.serviceType,
    this.pin,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactId: int.parse(json['id'].toString()),
      modelableType: json['modelable_type'],
      modelableId: json['modelable_id'].toString(),
      productRef: json['product_reference'].toString(),
      referenceId: json['reference_id'].toString(),
      purchaseAt: json['created_at'].toString(),
      amount: double.parse(json['amount_paid'].toString()),
      phoneNo: json['phone_no'].toString(),
      apiStatus: TransactionStatusExtension.fromApi(json['api_status'].toString()),
      status: int.parse(json['status'].toString()),
      message: json['message'].toString(),
      meterNo: json['meter_no'].toString(),
      serviceType: json['service_type'].toString(),
      token: json['token'].toString(),
      pin: json['pin'].toString()
    );
  }

  // Map<String, dynamic> toMap(TransactionModel card){
  //   return {
  //     'id': card.transactId,
  //     'title': card.productName,
  //     'time': card.purchaseAt,
  //     'category': card.category,
  //     'amount': card.amount,
  //     'isIncome': card.beneficiary,
  //     'status': card.status,
  //   };
  // }
}

