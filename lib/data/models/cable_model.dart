
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
      serviceId: json['service_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
        updatedAt: json['updated_at'],
        cableType: CableModel.fromJson(json['cable_type']), );
  }
}
