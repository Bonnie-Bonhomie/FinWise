class NotifyModel {
  String id;
  String title;
  String description;
  String date;
  String status;
  String updatedAt;

  NotifyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.updatedAt,
  });

  factory NotifyModel.fromJson(Map<String, dynamic> json) {
    return NotifyModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['data'].toString(),
      date: json['created_at'].toString(),
      status: json['status'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }

  Map<String, dynamic> toMap(NotifyModel card){
    return{
      'id': card.id,
      'title': card.title,
      'description': card.description,
      'date': card.date
    };
  }
}
