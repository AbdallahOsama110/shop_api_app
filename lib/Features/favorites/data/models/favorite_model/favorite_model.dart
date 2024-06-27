import 'favorite_data_model.dart';

class FavoriteModel {
  bool? status;
  FavoriteDataModel? data;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    data = json['data'] == null
        ? null
        : FavoriteDataModel.fromJson(json['data'] as Map<String, dynamic>);
  }
}
