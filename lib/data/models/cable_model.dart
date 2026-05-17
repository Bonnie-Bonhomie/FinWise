class TvModel {
  final String name;
  final String abbrev;
  final String description;

  TvModel({
    required this.name,
    required this.abbrev,
    required this.description,
  });
}

class TvServiceModel {
  final String title;
  final String duration;
  final String amount;

  TvServiceModel({
    required this.title,
    required this.amount,
    required this.duration,
  });
}

class CableModel {
  int id;
  String status;
  String name;
  String serviceId;
  String createdAt;
  String updatedAt;

  CableModel({
    required this.id,
    required this.name,
    required this.serviceId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CableModel.fromJson(Map<String, dynamic> json) {
    return CableModel(
      id: json['id'],
      name: json['name'],
      serviceId: json['serviceId'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class CableBundle {
  String id;
  String name;
  String price;
  String cableCode;
  String cableTypeId;
  String status;
  String createdAt;
  String updatedAt;
  CableModel cableType;

  CableBundle({
    required this.id,
    required this.name,
    required this.price,
    required this.cableCode,
    required this.cableTypeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cableType
  });

  factory CableBundle.fromJson(Map<String, dynamic> json){
    return CableBundle(id: json['id'].toString(),
        name: json['name'],
        price: json['price'],
        cableCode: json['cablecode'],
        cableTypeId: json['cabletype_id'],
        status: json['status'].toString(),
        createdAt: json['created_at'],
        updatedAt: json['updatedAt'],
        cableType: json['cable_type'], );
  }
}
