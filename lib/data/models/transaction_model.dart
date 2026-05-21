// Model

import '../../core/constant.dart';

class TransactionModel {
  final int transactId;
  final String modelableType;
  final int modelableId;
  String referenceId;
  String productRef;
  final String purchaseAt;
  final Categories? category;
  final double amount;
  final String phoneNo;
  int? status;
  final TransactionStatus apiStatus;
  String? message;
  String? meterNo;
  String? token;
  String? serviceType;

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
    this.serviceType
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactId: json['id'],
      modelableType: json['modelable_type'],
      modelableId: json['modelable_id'],
      productRef: json['product_reference'],
      referenceId: json['reference_id'],
      purchaseAt: json['created_at'],
      amount: json['amount_paid'],
      phoneNo: json['phone_no'],
      apiStatus: json['api_status'],
      status: json['status'],
      message: json['message'],
      meterNo: json['meter_no'],
      serviceType: json['service_type'],
      token: json['token']
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

