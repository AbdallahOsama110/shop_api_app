import 'package:shop_api_app/Features/home/data/models/home_data_model/product_model.dart';

class ProductDetailsModel {
  bool? status;
  ProductModel? data;

  ProductDetailsModel({this.status, this.data});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        status: json['status'] as bool?,
        data: json['data'] == null ? null : ProductModel.fromJson(json['data']),
      );
}
