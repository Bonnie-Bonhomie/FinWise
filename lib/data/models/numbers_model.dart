import 'package:fin_wise/core/constant.dart';

class AirtimeApiModel {
  final String status;
  final String transactionId;
  final String beneficiary;
  final String productName;

  AirtimeApiModel({
    required this.status,
    required this.beneficiary,
    required this.productName,
    required this.transactionId,
  });

  factory AirtimeApiModel.fromJson(Map<String, dynamic> json) {
    return AirtimeApiModel(
      status: json['status'],
      beneficiary: json['beneficiary'],
      productName: json['product_name'],
      transactionId: json['transaction_id'],
    );
  }
}

class NumbersModel {
  ServiceProvider provider;
  final String number;
  final double amount;

  NumbersModel({
    required this.provider,
    required this.number,
    required this.amount,
  });
}

class NetworksModel {
  String name;
  String imgPath;
  int id;
  String serviceId;
  String? createdAt;
  String? updatedAt;
  String networkCode;
  String status;

  NetworksModel({
    required this.name,
    required this.id,
    required this.imgPath,
    required this.status,
    required this.networkCode,
    required this.serviceId,
    this.createdAt,
    this.updatedAt,
  });

  factory NetworksModel.fromJson(Map<String, dynamic> json) {
    return NetworksModel(
      name: json['name'],
      id: json['id'],
      imgPath: json['image'],
      status: json['status'],
      networkCode: json['network_code'],
      serviceId: json['service_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}
