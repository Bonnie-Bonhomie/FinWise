class UserModel {
  String name;
  String mail;
  String id;
  String token;
  String pNumber;

  // String

  UserModel({
    required this.name,
    required this.mail,
    required this.id,
    required this.token,
    required this.pNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      pNumber: json['pNumber'],
      name: json["name"],
      mail: json['mail'],
      id: json['id'].toString(),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson(UserModel card) {
    return {
      'name': card.name,
      'number': card.pNumber,
      'mail': card.mail,
      'password': card.id,
      'token': card.token,
    };
  }
}
