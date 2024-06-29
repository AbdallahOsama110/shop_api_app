import 'item.dart';

class PaypalItemListModel {
  List<PaypalItemModel>? items;

  PaypalItemListModel({this.items});

  factory PaypalItemListModel.fromJson(Map<String, dynamic> json) {
    return PaypalItemListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => PaypalItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
      };
}
