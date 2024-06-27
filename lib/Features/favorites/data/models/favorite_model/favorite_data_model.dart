import 'fav_data.dart';

class FavoriteDataModel {
  int? currentPage;
  List<FavData>? data;

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] as int?;
    data = (json['data'] as List<dynamic>?)
        ?.map((e) => FavData.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
