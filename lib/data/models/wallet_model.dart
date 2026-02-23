

class WalletModel {

  String id;
  double accBalance;
  double income;
  double expense;
  double spendingLimit;

  WalletModel({
    required this.id,
    required this.accBalance,
    required this.income,
    required this.expense,
    required this.spendingLimit
  });

  factory WalletModel.fromJson(Map<String, dynamic> json){
    return WalletModel(id: json['id'].toString(),
        accBalance: json['accBalance'],
        income: json['income'],
        expense: json['expense'],
        spendingLimit: json['spendingLimit']);
  }

  toMap(WalletModel card){
    return{
      'id': card.id,
      'accBalance': card.accBalance,
      'income': card.income,
      'expense': card.expense,
      'spendingLimit': card.spendingLimit
    };
  }
}