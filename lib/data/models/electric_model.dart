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
      id: json['id'].toString(),
      name: json['name'].toString(),
      electricCode: json['electricode'].toString(),
      imgPath: json['image'].toString(),
      price: json['price'].toString(),
      status: json['status'].toString(),
      updatedAt: json['updated_at'].toString(),
      createdAt: json['created_at'].toString(),
    );
  }
}


class ElectAmount {

  String amount;
  int id;
  String status;
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
        status: json['status'].toString(),
        createdAt: json['created_at'].toString(),
        updatedAt: json['updated_at'].toString());
  }
}
