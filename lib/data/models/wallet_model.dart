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
    required this.updatedAt, required this.createdAt
  });

  factory WalletModel.fromJson(Map<String, dynamic> json){
    return WalletModel(id: json['id'].toString(),
        accBalance: json['balance'].toString(),
        accountName: json['accountName'],
        bankType: json['bank_type'],
        userId: json['user_id'].toString(),
        accReference: json['accountReference'],
        reserveRef: json['reservationReference'],
        monifyAccNo: json['monifyAccNo'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at']);
  }

}