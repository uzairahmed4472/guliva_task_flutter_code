import 'package:guliva_interview_task/models/vehicleData_model.dart';

class ResponseModel {
  bool? success;
  String? message;
  List<VehicleData>? data;

  ResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<VehicleData>.from(
              json['data'].map((x) => VehicleData.fromJson(x)))
          : [], // Handle null case for 'data'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null
          ? List<dynamic>.from(data!.map((x) => x.toJson()))
          : [], // Handle null case for 'data'
    };
  }
}




