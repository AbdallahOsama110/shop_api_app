import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../settings/data/models/location_model/location_data.dart';

class AddressItemAndHeaderWidget extends StatelessWidget {
  const AddressItemAndHeaderWidget({
    super.key,
    this.locationData,
    this.isHeader = false,
  });
  final LocationData? locationData;
  final bool isHeader;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: isHeader,
      builder: (context) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.circleCheck,
              size: 30.sp, color: scaffoldBackgroundColorDark),
          title: Text(
            locationData?.name ?? 'address name',
            style: TextStyle(fontSize: 13.25.sp),
          ),
          subtitle: Text(
            '${locationData?.details ?? 'street'} ${locationData?.region ?? 'region'} ${locationData?.city ?? 'city'}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10.25.sp),
          ),
        );
      },
      fallback: (context) {
        return Container(
          decoration: BoxDecoration(
            color: scaffoldBackgroundColorLight,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(Icons.location_history_rounded,
                size: 30.sp, color: scaffoldBackgroundColorDark),
            title: Text(
              locationData?.name ?? 'address name',
              style: TextStyle(fontSize: 13.25.sp),
            ),
            subtitle: Text(
              '${locationData?.details ?? 'street'} ${locationData?.region ?? 'region'} ${locationData?.city ?? 'city'}',
              style: TextStyle(fontSize: 10.25.sp),
            ),
          ),
        );
      },
    );
  }
}
