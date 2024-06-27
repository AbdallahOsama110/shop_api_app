import 'data.dart';

class GetOrderDetailsModel {
	bool? status;
	dynamic message;
	Data? data;

	GetOrderDetailsModel({this.status, this.message, this.data});

	factory GetOrderDetailsModel.fromJson(Map<String, dynamic> json) {
		return GetOrderDetailsModel(
			status: json['status'] as bool?,
			message: json['message'] as dynamic,
			data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data?.toJson(),
			};
}
