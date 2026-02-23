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
  final String type;
  final double price;
  final String days;
  final String uid;

  DataPlan({
    required this.name,
    required this.type,
    required this.uid,
    required this.days,
    required this.price,
  });

  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      uid: json['uid'] ?? '',
      days: json['days'] ?? '',
      price: json['price'] ?? '',
    );
  }
}
