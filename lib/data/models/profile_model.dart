class ProfileModel {

  String name;
  String mail;
  String createdAt;
  String updateAt;
  String phone;
  String? transactionPin;
  String? verificationCode;
  String? verificationExpireAt;
  String? accountStatus;
  String? referBy;
  String? referralCode;
  String? dateOfBirth;
  String? profileImage;


  ProfileModel({
    required this.name,
    required this.mail,
    required this.createdAt,
    required this.updateAt,
    required this.phone,
    this.transactionPin,
    this.verificationCode,
    this.verificationExpireAt,
    this.accountStatus,
    this.referBy,
    this.referralCode,
    this.dateOfBirth,
    this.profileImage
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(name: json['name'],
        mail: json['mail'],
        createdAt: json['created_at'],
        updateAt: json['update_at'],
        phone: json['phone'],
        transactionPin: json['transaction_pin'],
      verificationCode: json['verification_code'],
      verificationExpireAt: json['verification_expire_at'],
      accountStatus: json['account_status'],
      referBy: json['refer_by'],
      referralCode: json['referral_code'],
      dateOfBirth: json['date_of_birth'],
      profileImage: json['profile_image']

    );
  }

  Map<String, dynamic> toJson(){

    return{
      'mail': mail,
      'name': name,
      'create_at': createdAt,
      'update_at': updateAt,
      'transaction_pin': transactionPin,
      'verification_code': verificationCode,
      'verification_expire_at': verificationExpireAt,
      'account_status': accountStatus,
      'refer_by': referBy,
      'referral_code': referralCode,
      'date_of_birth': dateOfBirth,
      'profile_image': profileImage,
    };
  }
}