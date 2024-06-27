import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/consts.dart';
import '../../../data/models/location_model/location_data.dart';
import '../../view_model/location cubit/location_cubit.dart';
import 'address_bottom_sheet.dart';

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget({
    super.key,
    required this.locationData,
  });
  final LocationData? locationData;
  @override
  Widget build(BuildContext context) {
    var locationCubit = LocationCubit.get(context);
    final nameController = TextEditingController();
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final regionController = TextEditingController();
    final latitudeController = TextEditingController();
    final longitudeController = TextEditingController();
    final notesController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Slidable(
          key: Key('${locationData?.id ?? UniqueKey()}'),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (_) =>
                    locationCubit.deleteAddress(id: locationData?.id ?? 0),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  nameController.text = locationData?.name ?? '';
                  streetController.text = locationData?.details ?? 'street';
                  cityController.text = locationData?.city ?? 'city';
                  regionController.text = locationData?.region ?? 'region';
                  latitudeController.text =
                      locationData?.latitude.toString() ?? '';
                  longitudeController.text =
                      locationData?.longitude.toString() ?? '';
                  notesController.text = locationData?.notes ?? 'Notes';
                  addressBottomSheet(
                    context,
                    formKey,
                    context,
                    nameController,
                    streetController,
                    cityController,
                    regionController,
                    latitudeController,
                    longitudeController,
                    notesController,
                    false,
                    id: locationData?.id ?? 0,
                    lat: locationData?.latitude.toString() ?? '',
                    long: locationData?.longitude.toString() ?? '',
                  );
                },
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.edit_location_alt_rounded,
                label: 'Edit',
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              LocationCubit.get(context).openMap(
                lat: locationData?.latitude,
                long: locationData?.longitude,
              );
            },
            leading: Icon(Icons.location_history_rounded,
                size: 35.sp, color: scaffoldBackgroundColorDark),
            title: Text(locationData?.name ?? 'address name'),
            subtitle: Text(
              '${locationData?.details ?? 'street'} ${locationData?.region ?? 'region'} ${locationData?.city ?? 'city'}',
            ),
          ),
        ),
      ),
    );
  }
}
