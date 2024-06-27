import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_api_app/Features/settings/data/models/location_model/location_data.dart';
import '../../../../../core/utils/consts.dart';
import '../../view model/payment cubit/payment_cubit.dart';
import 'address_item_header_widget.dart';

class SelectPaymentAddressDropdown extends StatelessWidget {
  const SelectPaymentAddressDropdown({super.key, required this.paymentCubit});
  final PaymentCubit paymentCubit;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Text(
          'Select Address',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: size.width * .05),
        CustomDropdown<LocationData>(
          closedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          expandedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          listItemPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          initialItem: paymentCubit.selectedAddress,
          decoration: CustomDropdownDecoration(
            closedSuffixIcon: const Icon(
              FontAwesomeIcons.angleDown,
              color: scaffoldBackgroundColorDark,
            ),
            closedBorderRadius: BorderRadius.circular(15),
            expandedBorderRadius: BorderRadius.circular(15),
          ),
          hintText: 'Select Address',
          items: paymentCubit.getAddressModel?.data?.data ?? [],
          onChanged: (value) => paymentCubit.setActivePaymentAddress(value),
          headerBuilder: (context, selectedItem, enabled) =>
              AddressItemAndHeaderWidget(
            locationData: selectedItem,
            isHeader: true,
          ),
          listItemBuilder: (context, item, isSelected, onItemSelect) =>
              AddressItemAndHeaderWidget(locationData: item),
        ),
      ],
    );
  }
}
