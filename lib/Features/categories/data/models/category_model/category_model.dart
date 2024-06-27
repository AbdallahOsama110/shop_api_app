import 'data.dart';

class CategoryModel {
  final bool? status;
  final dynamic message;
  final CategoryDataModel? data;

  const CategoryModel({this.status, this.message, this.data});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json['status'] as bool?,
        message: json['message'] as dynamic,
        data: json['data'] == null
            ? null
            : CategoryDataModel.fromJson(json['data'] as Map<String, dynamic>),
      );
}
