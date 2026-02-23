class AnlysModel{

  double expense;
  double income;

  AnlysModel({
    required this.expense,
    required this.income,
});

  factory AnlysModel.fromJson(Map<String, dynamic> json){
    return AnlysModel( expense: json['expense'], income: json['income']);
  }

  Map<String, dynamic> toJson(AnlysModel card){
    return {
      'expense': card.expense,
      'income': card.income
    };
  }
}
