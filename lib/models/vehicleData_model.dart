import 'package:guliva_interview_task/models/trip_model.dart';
import 'package:guliva_interview_task/models/user_model.dart';

class VehicleData {
  int? id;
  String? createdAt;
  String? typeOfVehicle;
  dynamic drivingYears;
  bool? isDefault;
  bool? isPassenger;
  dynamic ownership;
  dynamic aidRequired;
  dynamic otherAid;
  dynamic parking;
  dynamic involvedInAccident;
  dynamic securityForVehicle;
  dynamic bookedForTrafficOffense;
  dynamic usage;
  String? name;
  String? model;
  bool? isThirdPartyInsurance;
  String? color;
  String? year;
  int? value;
  String? registrationNumber;
  String? engineNumber;
  String? chassisNumber;
  double? distanceCovered;
  double? amountBilled;
  dynamic minimumPayablePremiumAmount;
  dynamic engineCapacity;
  String? frontView;
  String? sideView;
  String? backView;
  String? driversLicense;
  String? topView;
  dynamic insuranceCertificate;
  String? modeOfInsurance;
  String? thirdPartyInsurance;
  String? proofOfOwnership;
  User? user;
  List<Trip>? trips;

  VehicleData({
    this.id,
    this.createdAt,
    this.typeOfVehicle,
    this.drivingYears,
    this.isDefault,
    this.isPassenger,
    this.ownership,
    this.aidRequired,
    this.otherAid,
    this.parking,
    this.involvedInAccident,
    this.securityForVehicle,
    this.bookedForTrafficOffense,
    this.usage,
    this.name,
    this.model,
    this.isThirdPartyInsurance,
    this.color,
    this.year,
    this.value,
    this.registrationNumber,
    this.engineNumber,
    this.chassisNumber,
    this.distanceCovered,
    this.amountBilled,
    this.minimumPayablePremiumAmount,
    this.engineCapacity,
    this.frontView,
    this.sideView,
    this.backView,
    this.driversLicense,
    this.topView,
    this.insuranceCertificate,
    this.modeOfInsurance,
    this.thirdPartyInsurance,
    this.proofOfOwnership,
    this.user,
    this.trips,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      id: json['id'],
      createdAt: json['createdAt'],
      typeOfVehicle: json['typeOfVehicle'],
      drivingYears: json['drivingYears'],
      isDefault: json['default'],
      isPassenger: json['isPassenger'],
      ownership: json['ownership'],
      aidRequired: json['aidRequired'],
      otherAid: json['otherAid'],
      parking: json['parking'],
      involvedInAccident: json['involvedInAccident'],
      securityForVehicle: json['securityForVehicle'],
      bookedForTrafficOffense: json['bookedForTrafficOffense'],
      usage: json['usage'],
      name: json['name'],
      model: json['model'],
      isThirdPartyInsurance: json['isThirdPartyInsurance'],
      color: json['color'],
      year: json['year'],
      value: json['value'],
      registrationNumber: json['registrationNumber'],
      engineNumber: json['engineNumber'],
      chassisNumber: json['chassisNumber'],
      distanceCovered: (json['distanceCovered'] as num?)?.toDouble(),
      amountBilled: (json['amountBilled'] as num?)?.toDouble(),
      minimumPayablePremiumAmount: json['minimumPayablePremiumAmount'],
      engineCapacity: json['engineCapacity'],
      frontView: json['frontView'],
      sideView: json['sideView'],
      backView: json['backView'],
      driversLicense: json['driversLicense'],
      topView: json['topView'],
      insuranceCertificate: json['insuranceCertificate'],
      modeOfInsurance: json['modeOfInsurance'],
      thirdPartyInsurance: json['thirdPartyInsurance'],
      proofOfOwnership: json['proofOfOwnership'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      trips: json['trips'] != null
          ? List<Trip>.from(json['trips'].map((x) => Trip.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'typeOfVehicle': typeOfVehicle,
      'drivingYears': drivingYears,
      'default': isDefault,
      'isPassenger': isPassenger,
      'ownership': ownership,
      'aidRequired': aidRequired,
      'otherAid': otherAid,
      'parking': parking,
      'involvedInAccident': involvedInAccident,
      'securityForVehicle': securityForVehicle,
      'bookedForTrafficOffense': bookedForTrafficOffense,
      'usage': usage,
      'name': name,
      'model': model,
      'isThirdPartyInsurance': isThirdPartyInsurance,
      'color': color,
      'year': year,
      'value': value,
      'registrationNumber': registrationNumber,
      'engineNumber': engineNumber,
      'chassisNumber': chassisNumber,
      'distanceCovered': distanceCovered,
      'amountBilled': amountBilled,
      'minimumPayablePremiumAmount': minimumPayablePremiumAmount,
      'engineCapacity': engineCapacity,
      'frontView': frontView,
      'sideView': sideView,
      'backView': backView,
      'driversLicense': driversLicense,
      'topView': topView,
      'insuranceCertificate': insuranceCertificate,
      'modeOfInsurance': modeOfInsurance,
      'thirdPartyInsurance': thirdPartyInsurance,
      'proofOfOwnership': proofOfOwnership,
      'user': user?.toJson(),
      'trips': trips != null
          ? List<dynamic>.from(trips!.map((x) => x.toJson()))
          : [],
    };
  }
}