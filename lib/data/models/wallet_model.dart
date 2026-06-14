class WalletModel {
  String id;
  String userId;
  String accBalance;
  String bankType;
  String accountName;
  String accReference;
  String reserveRef;
  String monifyAccNo;
  String createdAt;
  String updatedAt;

  WalletModel({
    required this.id,
    required this.accBalance,
    required this.accountName,
    required this.bankType,
    required this.userId,
    required this.accReference,
    required this.reserveRef,
    required this.monifyAccNo,
    required this.updatedAt,
    required this.createdAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'].toString(),
      accBalance: json['balance'].toString(),
      accountName: json['accountName'],
      bankType: json['bank_type'],
      userId: json['user_id'].toString(),
      accReference: json['accountReference'],
      reserveRef: json['reservationReference'],
      monifyAccNo: json['monifyAccNo'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}

class BankModel {
  final String id;
  final String status;
  final String name;
  final String url;
  final String imgUrl;
  final String method;
  final String createdAt;
  String? updatedAt;

  BankModel({
    required this.id,
    required this.status,
    required this.name,
    required this.url,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.method,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'].toString(),
      status: json['status'].toString(),
      name: json['name'],
      url: json['url'],
      imgUrl: json['images'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      method: json['method'],
    );
  }
}
