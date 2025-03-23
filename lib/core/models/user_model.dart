class UserModel {
  final String uid;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? address;
  final String? profilePictureUrl;

  UserModel({
    required this.uid,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"],
      email: map["email"],
      firstName: map["firstname"],
      lastName: map["lastName"],
      phoneNumber: map["phoneNumber"],
      address: map["address"],
      profilePictureUrl: map["profilePictureUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "address": address,
      "profilePictureUrl": profilePictureUrl
    };
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? profilePictureUrl,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  bool isProfileComplete() {
    return firstName != null && lastName != null && phoneNumber != null && address != null && profilePictureUrl != null;
  }
}
