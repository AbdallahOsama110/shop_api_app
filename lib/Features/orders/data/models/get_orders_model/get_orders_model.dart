import 'data.dart';

class GetOrdersModel {
	bool? status;
	dynamic message;
	Data? data;

	GetOrdersModel({this.status, this.message, this.data});

	factory GetOrdersModel.fromJson(Map<String, dynamic> json) {
		return GetOrdersModel(
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
