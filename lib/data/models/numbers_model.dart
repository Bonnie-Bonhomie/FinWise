import 'package:fin_wise/core/constant.dart';

class AirtimeApiModel {
  final String status;
  final String reference;

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
