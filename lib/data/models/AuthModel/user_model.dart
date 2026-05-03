class UserModel {
  String name;
  String email;
  String id;
  String token;
  String pNumber;

  // String

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.token,
    required this.pNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      pNumber: json['phone'],
      name: json["name"],
      email: json['mail'],
      id: json['id'].toString(),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson(UserModel card) {
    return {
      'name': card.name,
      'phone': card.pNumber,
      'email': card.email,
      'id': card.id,
      'token': card.token,
    };
  }
}
