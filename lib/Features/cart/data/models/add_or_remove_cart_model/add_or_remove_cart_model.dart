import 'add_or_remove_cart_data.dart';

class AddOrRemoveCartModel {
  bool? status;
  String? message;
  AddOrRemoveCartData? data;

  AddOrRemoveCartModel({this.status, this.message, this.data});

  factory AddOrRemoveCartModel.fromJson(Map<String, dynamic> json) {
    return AddOrRemoveCartModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AddOrRemoveCartData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
