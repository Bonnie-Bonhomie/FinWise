class FaqsModel {
  String id;
  String title;
  String description;
  String createdAt;
  String slug;
  String type;
  String status;

  FaqsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.slug,
    required this.type,
    required this.status,
  });

  factory FaqsModel.fromJson(Map<String, dynamic> json) {
    return FaqsModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      createdAt: json['created_at'].toString(),
      slug: json['slug'].toString(),
      type: json['type'].toString(),
      status: json['status'].toString(),
    );
  }
}
