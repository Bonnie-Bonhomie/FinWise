class DataApiModel {


  final int id;
  int status;
  final String modelableType;
  String modelableId;
  String userId;
  double amount;
  String? referenceId;
  String productRefer;
  String phone;
  String? createdAt;
  String? updatedAt;
  String apiStatus;


  DataApiModel({
    required this.status,
    required this.id,
    required this.amount,
    required this.userId,
    required this.modelableId,
    required this.modelableType,
    this.referenceId,
    required this.productRefer,
    required this.phone,
    this.createdAt,
    this.updatedAt,
    required this.apiStatus
  });

  factory DataApiModel.fromJson(Map<String, dynamic> json){
    return DataApiModel(status: json['status'] ?? 1,
        id: json['id'] ?? 1,
        amount: json['amount'] ?? '',
        userId: json['userId'],
        modelableId: json['modelableId'],
        modelableType: json['modelableType'],
        productRefer: json['productRefer'],
        phone: json['phone'],
        createdAt: json['createdAt'] ?? DateTime.now().microsecondsSinceEpoch,
        updatedAt: json['updatedAt'] ?? DateTime.now().microsecondsSinceEpoch,
        apiStatus: json['apiStatus']);
  }
}


class DataPlan {
  final String name;
  final String dataCode;
  final String price;
  String id;
  String status;
  String networkId;
  String frequency;
  String hotPlans;
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
    required this.hotPlans
  });

  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
        name: json['name'].toString() ,
        dataCode: json['datacode'].toString() ?? '',
        id: json['id'].toString(),
        frequency: json['frequency'].toString() ?? '',
        price: json['price'].toString(),
        status: json['status'].toString() ,
        networkId: json['network_id'].toString(),
        createdAt: json['created_at'].toString(),
        updatedAt: json['updated_at'].toString(),
        hotPlans: json['hot_plans'].toString()
    );
  }
}
