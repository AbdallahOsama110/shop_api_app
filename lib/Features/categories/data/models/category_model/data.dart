import 'datum.dart';

class CategoryDataModel {
  final int? currentPage;
  final List<CategoryDataListModel>? data;

  const CategoryDataModel({
    this.currentPage,
    this.data,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        currentPage: json['current_page'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) =>
                CategoryDataListModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

}
