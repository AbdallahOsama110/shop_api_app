import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../view_models/Search Cubit/search_cubit.dart';
import '../../view_models/Search Cubit/search_state.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width * .8,
          child: TextField(
            controller: controller,
            onChanged: (value) async {},
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onSubmitted: (value) async {
              if (controller.text.isNotEmpty || controller.text != '') {
                await SearchCubit.get(context)
                    .searchProduct(text: controller.text);
              }
            },
            //autofocus: true,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 12.sp),
            decoration: InputDecoration(
              enabledBorder: buildOutlineInputBorder(),
              focusedBorder: buildOutlineInputBorder(),
              hintText: 'Search',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey, fontSize: 12.sp),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Opacity(
                  opacity: .8,
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(
        15,
      ),
    );
  }
}
