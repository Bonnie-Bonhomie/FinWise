class TvModel {

  final String name;
  final String abbrev;
  final String description;

  TvModel({
    required this.name,
    required this.abbrev,
    required this.description
  });

}

class TvServiceModel {

  final String title;
  final String duration;
  final String amount;

  TvServiceModel({
    required this.title,
    required this.amount,
    required this.duration
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
    required this.updatedAt
  });

  factory CableModel.fromJson(Map<String, dynamic> json){
    return CableModel(id: json['id'],
        name: json['name'],
        serviceId: json['serviceId'],
        status: json['status'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}