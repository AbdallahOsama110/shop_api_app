import 'package:flutter/material.dart';
import 'package:shop_api_app/Features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:shop_api_app/Features/settings/presentation/view_model/location%20cubit/location_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_button.dart';

class AddOrEditLocation extends StatelessWidget {
  const AddOrEditLocation({
    super.key,
    required this.nameController,
    required this.streetController,
    required this.cityController,
    required this.regionController,
    required this.latitudeController,
    required this.longitudeController,
    required this.notesController,
    required this.loContext,
    required this.formKey,
    required this.isAddAddress,
    this.id = 0,
    this.lat = '',
    this.long = '',
  });
  final BuildContext loContext;
  final TextEditingController nameController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController regionController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final TextEditingController notesController;
  final GlobalKey<FormState> formKey;
  final bool isAddAddress;
  final int id;
  final String lat;
  final String long;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: size.height * .55,
        width: size.width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                isAddAddress ? 'Add new Address' : 'Edit Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                      controller: nameController, hintText: 'Loction Name'),
                  CustomTextFormField(
                      controller: streetController, hintText: 'Street'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                      controller: regionController, hintText: 'Region'),
                  CustomTextFormField(
                      controller: cityController, hintText: 'City'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                      controller: latitudeController, hintText: 'Latitude'),
                  CustomTextFormField(
                      controller: longitudeController, hintText: 'Longitude'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    controller: notesController,
                    hintText: 'Notes',
                    isNotes: true,
                  ),
                  CustomButton(
                    text: isAddAddress ? 'Add' : 'Edit',
                    width: size.width / 2.2,
                    overlayColor: Colors.greenAccent,
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? true) {
                        if (isAddAddress) {
                          LocationCubit.get(loContext).addNewAddress(
                            name: nameController.text,
                            city: cityController.text,
                            region: regionController.text,
                            street: streetController.text,
                            notes: notesController.text,
                          );
                        } else {
                          LocationCubit.get(loContext).updateAddress(
                            id: id,
                            name: nameController.text,
                            city: cityController.text,
                            region: regionController.text,
                            street: streetController.text,
                            lat: lat,
                            long: long,
                            notes: notesController.text,
                          );
                        }
                      }
                    },
                  )
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
