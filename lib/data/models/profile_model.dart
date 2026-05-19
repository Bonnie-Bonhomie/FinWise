class ProfileModel {

  String name;
  String id;
  String email;
  String createdAt;
  String updateAt;
  String phone;
  String username;
  String? transactionPin;
  String? emailVerifiedAt;
  String? verificationExpireAt;
  String? accountStatus;
  String? referBy;
  String? referralCode;
  String? dateOfBirth;
  String? profileImage;


  ProfileModel({
    required this.name,
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updateAt,
    required this.phone,
    required this.username,
    this.transactionPin,
    this.emailVerifiedAt,
    this.verificationExpireAt,
    this.accountStatus,
    this.referBy,
    this.referralCode,
    this.dateOfBirth,
    this.profileImage
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(name: json['name'] ?? '',
        id: json['id'].toString() ,
        email: json['email'],
        createdAt: json['created_at'] ?? '',
        updateAt: json['updated_at']?? '',
        phone: json['phone'] ?? '',
        username: json['username'],
        transactionPin: json['transaction_pin'],
      emailVerifiedAt: json['email_verified_at'],
      verificationExpireAt: json['verification_expire_at'],
      accountStatus: json['account_status'],
      referBy: json['refer_by'],
      referralCode: json['referral_code'],
      dateOfBirth: json['date_of_birth'],
      profileImage: json['profile_image']

    );
  }

  // Map<String, dynamic> toJson(){
  //
  //   return{
  //     'email': email,
  //     'id': id,
  //     'name': name,
  //     'created_at': createdAt,
  //     'updated_at': updateAt,
  //     'transaction_pin': transactionPin,
  //     'email_verified_at': emailVerifiedAt,
  //     'verification_expire_at': verificationExpireAt,
  //     'account_status': accountStatus,
  //     'refer_by': referBy,
  //     'referral_code': referralCode,
  //     'date_of_birth': dateOfBirth,
  //     'profile_image': profileImage,
  //   };
  // }
}