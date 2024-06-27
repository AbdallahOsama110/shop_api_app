import 'get_location_data.dart';

class GetAddressModel {
  bool? status;
  dynamic message;
  GetLocationData? data;

  GetAddressModel({this.status, this.message, this.data});

  factory GetAddressModel.fromJson(Map<String, dynamic> json) {
    return GetAddressModel(
      status: json['status'] as bool?,
      message: json['message'] as dynamic,
      data: json['data'] == null
          ? null
          : GetLocationData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
