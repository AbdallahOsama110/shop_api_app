import '../../../../home/data/models/home_data_model/product_model.dart';

class CategoryProductModel {
  bool status = false;
  CategoryProductDataModel? data;

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] == null
        ? null
        : CategoryProductDataModel.fromJson(json['data']);
  }
}

class CategoryProductDataModel {
  int? currentPage;
  List<ProductModel> data = [];

  CategoryProductDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((product) {
      data.add(ProductModel.fromJson(product));
    });
  }
}
