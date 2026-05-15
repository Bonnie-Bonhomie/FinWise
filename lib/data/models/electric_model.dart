class ElectModel {
  final String name;
  final String abbrev;

  ElectModel({required this.name, required this.abbrev});
}

class ElectDisco {
  String id;
  String name;
  String electricCode;
  String price;
  String status;
  String imgPath;
  String updatedAt;
  String createdAt;

  ElectDisco({
    required this.id,
    required this.name,
    required this.electricCode,
    required this.imgPath,
    required this.price,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  factory ElectDisco.fromJson(Map<String, dynamic> json) {
    return ElectDisco(
      id: json['id'],
      name: json['name'],
      electricCode: json['electricode'],
      imgPath: json['image'],
      price: json['price'],
      status: json['status'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }
}


class ElectAmount {

  String amount;
  int id;
  int status;
  String createdAt;
  String updatedAt;


  ElectAmount({
    required this.amount,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt
  });

  factory ElectAmount.fromJson(Map<String, dynamic> json){
    return ElectAmount(amount: json['amount'],
        id: json['id'],
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
