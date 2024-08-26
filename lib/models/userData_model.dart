class UserLoginModel {
  bool? success;
  String? message;
  Data? data;

  UserLoginModel({this.success, this.message, this.data});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? sex;
  String? createdAt;
  String? dob;
  int? walletBalance;
  dynamic pendingPayment;
  int? transactionPin;
  String? location;
  String? image;
  String? phoneNo;
  String? token;
  int? accountPin;
  String? nokFirstName;
  String? nokLastName;
  String? nokPhoneNumber;
  String? nokRelationship;
  int? distanceCovered;
  bool? isValidated;
  bool? isActive;
  bool? withEmail;
  bool? withGoogle;
  bool? withFacebook;
  int? planId;
  String? password;
  String? facebookUserId;
  int? hasActiveTrip;

  Data(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.sex,
      this.createdAt,
      this.dob,
      this.walletBalance,
      this.pendingPayment,
      this.transactionPin,
      this.location,
      this.image,
      this.phoneNo,
      this.token,
      this.accountPin,
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
      this.planId,
      this.password,
      this.facebookUserId,
      this.hasActiveTrip});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sex = json['sex'];
    createdAt = json['createdAt'];
    dob = json['dob'];
    walletBalance = json['walletBalance'];
    pendingPayment = json['pendingPayment'];
    transactionPin = json['transactionPin'];
    location = json['location'];
    image = json['image'];
    phoneNo = json['phoneNo'];
    token = json['token'];
    accountPin = json['accountPin'];
    nokFirstName = json['nok_First_Name'];
    nokLastName = json['nok_Last_Name'];
    nokPhoneNumber = json['nok_Phone_number'];
    nokRelationship = json['nok_Relationship'];
    distanceCovered = json['distanceCovered'];
    isValidated = json['isValidated'];
    isActive = json['isActive'];
    withEmail = json['withEmail'];
    withGoogle = json['withGoogle'];
    withFacebook = json['withFacebook'];
    planId = json['planId'];
    password = json['password'];
    facebookUserId = json['facebookUserId'];
    hasActiveTrip = json['hasActiveTrip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['sex'] = this.sex;
    data['createdAt'] = this.createdAt;
    data['dob'] = this.dob;
    data['walletBalance'] = this.walletBalance;
    data['pendingPayment'] = this.pendingPayment;
    data['transactionPin'] = this.transactionPin;
    data['location'] = this.location;
    data['image'] = this.image;
    data['phoneNo'] = this.phoneNo;
    data['token'] = this.token;
    data['accountPin'] = this.accountPin;
    data['nok_First_Name'] = this.nokFirstName;
    data['nok_Last_Name'] = this.nokLastName;
    data['nok_Phone_number'] = this.nokPhoneNumber;
    data['nok_Relationship'] = this.nokRelationship;
    data['distanceCovered'] = this.distanceCovered;
    data['isValidated'] = this.isValidated;
    data['isActive'] = this.isActive;
    data['withEmail'] = this.withEmail;
    data['withGoogle'] = this.withGoogle;
    data['withFacebook'] = this.withFacebook;
    data['planId'] = this.planId;
    data['password'] = this.password;
    data['facebookUserId'] = this.facebookUserId;
    data['hasActiveTrip'] = this.hasActiveTrip;
    return data;
  }
}
