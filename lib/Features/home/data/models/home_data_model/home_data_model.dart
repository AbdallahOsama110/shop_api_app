import 'data_model.dart';

class HomeDataModel {
  bool? status;
  DataModel? data;

  HomeDataModel({
    this.status,
    this.data,
  });
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] == null ? null : DataModel.fromJson(json['data']);
  }
}
