class DataApiModel {


  final bool status;
  final List<DataPlan> data;
  final Map<String, dynamic> error;
  final String message;

  DataApiModel({
    required this.status,
    required this.data,
    required this.error,
    required this.message
  });

  factory DataApiModel.fromJson(Map<String, dynamic> json){
    return DataApiModel(status: json['status'] ?? '',
        data: json['data'] ?? '',
        error: json['error'] ?? '',
        message: json['message'] ?? '');
  }
}


class DataPlan {
  final String name;
  final String dataCode;
  final String price;
  final String id;
  int status;
  int networkId;
  String frequency;
  int? hotPlans;
  String createdAt;
  String updatedAt;

  DataPlan({
    required this.name,
    required this.dataCode,
    required this.id,
    required this.status,
    required this.price,
    required this.updatedAt,
    required this.createdAt,
    required this.frequency,
    required this.networkId,
    this.hotPlans
  });

  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
      name: json['name'] ?? '',
      dataCode: json['datacode'] ?? '',
      id: json['id'] ?? '',
      frequency: json['frequency'] ?? '',
      price: json['price'] ?? '',
      status: json['status']?? 1,
      networkId: json['network_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      hotPlans: json['hot_plans']
    );
  }
}
