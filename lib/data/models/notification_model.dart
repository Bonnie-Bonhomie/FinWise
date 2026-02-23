class NotifyModel {
  String id;
  String title;
  String description;
  DateTime date;

  NotifyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory NotifyModel.fromJson(Map<String, dynamic> json) {
    return NotifyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
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
