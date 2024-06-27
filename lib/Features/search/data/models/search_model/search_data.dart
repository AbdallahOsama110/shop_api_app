import 'search_product_data.dart';

class SearchData {
  List<SearchProductData>? data;

  SearchData({
    this.data,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => SearchProductData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
