import 'data.dart';

class AddOrderModel {
	bool? status;
	String? message;
	Data? data;

	AddOrderModel({this.status, this.message, this.data});

	factory AddOrderModel.fromJson(Map<String, dynamic> json) => AddOrderModel(
				status: json['status'] as bool?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data?.toJson(),
			};
}
