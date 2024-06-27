import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/settings/presentation/view_model/location%20cubit/location_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import 'package:shop_api_app/core/widgets/empty_display_widget.dart';
import 'widgets/address_bottom_sheet.dart';
import 'widgets/address_item_widget.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});
  @override
  Widget build(BuildContext loContext) {
    final nameController = TextEditingController();
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final regionController = TextEditingController();
    final latitudeController = TextEditingController();
    final longitudeController = TextEditingController();
    final notesController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {
        if (state is AddNewLocationSuccess || state is UpdateAddressSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var locationCubit = LocationCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Location')),
          body: ConditionalBuilder(
            condition: state is LocationLoadingStates,
            builder: (BuildContext context) => const CustomLoadingIndicator(),
            fallback: (context) {
              return ConditionalBuilder(
                condition:
                    locationCubit.getAddressModel?.data?.data?.isNotEmpty ??
                        false,
                builder: (context) {
                  return ListView.builder(
                    itemCount:
                        locationCubit.getAddressModel?.data?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return AddressItemWidget(
                        locationData:
                            locationCubit.getAddressModel?.data?.data?[index],
                      );
                    },
                  );
                },
                fallback: (context) => const EmptyDisplayWidget(
                  message: 'Empty Address List',
                  image: 'assets/images/emptyLocation.json',
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await locationCubit.getCurrentLocation();
              streetController.text = locationCubit.street.toString();
              cityController.text = locationCubit.city.toString();
              regionController.text = locationCubit.region.toString();
              latitudeController.text = locationCubit.lat;
              longitudeController.text = locationCubit.long;
              notesController.text = 'Notes';
              if (context.mounted) {
                addressBottomSheet(
                  context,
                  formKey,
                  loContext,
                  nameController,
                  streetController,
                  cityController,
                  regionController,
                  latitudeController,
                  longitudeController,
                  notesController,
                  true,
                );
              }
            },
            backgroundColor: Colors.white,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            child: const Icon(
              Icons.my_location_rounded,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}
