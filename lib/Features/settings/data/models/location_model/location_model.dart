import 'location_data.dart';

class LocationModel {
  bool? status;
  String? message;
  LocationData? data;

  LocationModel({this.status, this.message, this.data});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : LocationData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
