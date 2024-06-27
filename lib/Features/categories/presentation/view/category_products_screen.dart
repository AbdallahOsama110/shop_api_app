import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/categories/presentation/view_model/cubit/category_cubit.dart';
import 'package:shop_api_app/Features/home/presentation/view_model/home%20cubit/home_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import '../../../home/presentation/view/widgets/products_gridview.dart';
import '../../data/models/category_model/datum.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({
    super.key,
    required this.categoryModel,
  });
  final CategoryDataListModel? categoryModel;
  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel?.name ?? ''),
      ),
      body: BlocProvider(
        create: (context) =>
            CategoryCubit()..getCategoryProducts(categoryModel?.id ?? 44),
        child: BlocConsumer<CategoryCubit, CategoryStates>(
          listener: (context, state) {
            if (state is GetCategoryProductLoadingState ||
                state is GetCategoryProductErrorState) {
              isEmpty = true;
            } else {
              isEmpty = false;
            }
          },
          builder: (context, state) {
            var categoryCubit = CategoryCubit.get(context).categoryProductModel;
            return ConditionalBuilder(
              condition: !isEmpty,
              builder: (context) => BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  return ProductsGridView(
                    products: categoryCubit?.data?.data ?? [],
                  );
                },
              ),
              fallback: (context) => const CustomLoadingIndicator(),
            );
          },
        ),
      ),
    );
  }
}
