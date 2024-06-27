import 'package:flutter/material.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';
import '../../../../../core/utils/consts.dart';
import 'add_or_edit_location_widget.dart';

Future<dynamic> addressBottomSheet(
  BuildContext context,
  GlobalKey<FormState> formKey,
  BuildContext loContext,
  TextEditingController nameController,
  TextEditingController streetController,
  TextEditingController cityController,
  TextEditingController regionController,
  TextEditingController latitudeController,
  TextEditingController longitudeController,
  TextEditingController notesController,
  bool isAddAddress, {
  int id = 0,
  String lat = '',
  String long = '',
}) {
  return showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    context: context,
    elevation: 0,
    backgroundColor: ShopCubit.get(context).isDark
        ? scaffoldBackgroundColorDark
        : scaffoldBackgroundColorLight,
    builder: ((builder) {
      return AddOrEditLocation(
        formKey: formKey,
        loContext: loContext,
        nameController: nameController,
        streetController: streetController,
        cityController: cityController,
        regionController: regionController,
        latitudeController: latitudeController,
        longitudeController: longitudeController,
        notesController: notesController,
        isAddAddress: isAddAddress,
        id: id,
        lat: lat,
        long: long,
      );
    }),
  );
}
