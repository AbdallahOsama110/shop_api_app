import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/home/presentation/view_model/home%20cubit/home_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import '../../../../../core/widgets/arrow_back_icon_button.dart';
import 'custom_search_text_field.dart';
import 'search_product_listview.dart';

class SearchScreenBody extends StatelessWidget {
  SearchScreenBody({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetProductDetailsLoadingState) {
          return const CustomLoadingIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ArrowBackIconButton(),
                  const Spacer(flex: 1),
                  CustomSearchTextField(controller: controller),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Expanded(
              child: SearchProductsListView(),
            ),
          ],
        );
      },
    );
  }
}
