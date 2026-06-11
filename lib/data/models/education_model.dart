class EduModel {

  final String schoolName;
  final String abbrev;
  final String imgPath;
  final String serviceName;
  final double amount;

  EduModel({
    required this.schoolName,
    required this.abbrev,
    required this.imgPath,
    required this.serviceName,
    required this.amount,
  });
}


class ExamCardModel {

  int id;
  String status;
  String name;
  String serviceName;
  String price;
  String variationCode;
  String createdAt;
  String updatedAt;

  ExamCardModel({
    required this.id,
    required this.status,
    required this.name,
    required this.serviceName,
    required this.price,
    required this.variationCode,
    required this.createdAt,
    required this.updatedAt
  });

  factory ExamCardModel.fromJson(Map<String, dynamic> json){
    return ExamCardModel(id: json['id'],
        status: json['status'],
        name: json['name'],
        serviceName: json['service_name'],
        price: json['price'],
        variationCode: json['variation_code'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}

class EduApiModel{

  int id;
  String status;
  String modelableType;
  String modelableId;
  String userId;
  String amountPaid;
  String productRef;
  String token;
  String phone;
  String apiStatus;
  String createdAt;
  String updatedAt;
  String referenceId;


  EduApiModel({
    required this.id,
    required this.status,
    required this.modelableType,
    required this.modelableId,
    required this.userId,
    required this.productRef,
    required this.amountPaid,
    required this.phone,
    required this.token,
    required this.apiStatus,
    required this.referenceId,
    required this.createdAt,
    required this.updatedAt
});


}
