class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  dynamic sex;
  String? createdAt;
  String? dob;
  double? walletBalance;
  dynamic pendingPayment;
  dynamic location;
  dynamic image;
  bool? hasActiveTrip;
  String? phoneNo;
  String? token;
  dynamic accountPin;
  dynamic facebookUserId;
  String? nokFirstName;
  String? nokLastName;
  String? nokPhoneNumber;
  String? nokRelationship;
  double? distanceCovered;
  bool? isValidated;
  bool? isActive;
  bool? withEmail;
  bool? withGoogle;
  bool? withFacebook;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.sex,
    this.createdAt,
    this.dob,
    this.walletBalance,
    this.pendingPayment,
    this.location,
    this.image,
    this.hasActiveTrip,
    this.phoneNo,
    this.token,
    this.accountPin,
    this.facebookUserId,
    this.nokFirstName,
    this.nokLastName,
    this.nokPhoneNumber,
    this.nokRelationship,
    this.distanceCovered,
    this.isValidated,
    this.isActive,
    this.withEmail,
    this.withGoogle,
    this.withFacebook,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      sex: json['sex'],
      createdAt: json['createdAt'],
      dob: json['dob'],
      walletBalance: (json['walletBalance'] as num?)?.toDouble(),
      pendingPayment: json['pendingPayment'],
      location: json['location'],
      image: json['image'],
      hasActiveTrip: json['hasActiveTrip'],
      phoneNo: json['phoneNo'],
      token: json['token'],
      accountPin: json['accountPin'],
      facebookUserId: json['facebookUserId'],
      nokFirstName: json['nokFirstName'],
      nokLastName: json['nokLastName'],
      nokPhoneNumber: json['nokPhoneNumber'],
      nokRelationship: json['nokRelationship'],
      distanceCovered: (json['distanceCovered'] as num?)?.toDouble(),
      isValidated: json['isValidated'],
      isActive: json['isActive'],
      withEmail: json['withEmail'],
      withGoogle: json['withGoogle'],
      withFacebook: json['withFacebook'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'sex': sex,
      'createdAt': createdAt,
      'dob': dob,
      'walletBalance': walletBalance,
      'pendingPayment': pendingPayment,
      'location': location,
      'image': image,
      'hasActiveTrip': hasActiveTrip,
      'phoneNo': phoneNo,
      'token': token,
      'accountPin': accountPin,
      'facebookUserId': facebookUserId,
      'nokFirstName': nokFirstName,
      'nokLastName': nokLastName,
      'nokPhoneNumber': nokPhoneNumber,
      'nokRelationship': nokRelationship,
      'distanceCovered': distanceCovered,
      'isValidated': isValidated,
      'isActive': isActive,
      'withEmail': withEmail,
      'withGoogle': withGoogle,
      'withFacebook': withFacebook,
    };
  }
}
