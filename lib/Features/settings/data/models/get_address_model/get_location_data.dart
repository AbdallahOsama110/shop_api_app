import '../location_model/location_data.dart';

class GetLocationData {
  int? currentPage;
  List<LocationData>? data;

  GetLocationData({
    this.currentPage,
    this.data,
  });

  factory GetLocationData.fromJson(Map<String, dynamic> json) =>
      GetLocationData(
        currentPage: json['current_page'] as int?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => LocationData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
