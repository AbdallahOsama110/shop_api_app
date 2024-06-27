import 'search_data.dart';

class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel({this.status, this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json['status'] as bool?,
        data: json['data'] == null
            ? null
            : SearchData.fromJson(json['data'] as Map<String, dynamic>),
      );
}
