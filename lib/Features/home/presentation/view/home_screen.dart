import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/home/presentation/view/product%20details/view/widgets/custom_home_shimmer.dart';
import '../../../../core/widgets/custom_failure_widget.dart';
import '../view_model/home cubit/home_cubit.dart';
import 'banner_widget.dart';
import 'widgets/custom_listview.dart';
import 'widgets/products_gridview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context)
      ..getCategories()
      ..getFavorites()
      ..getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var categoryCubit = HomeCubit.get(context).categoryModel?.data;
        var homeDataModelCubit = HomeCubit.get(context).homeDataModelCubit;
        if (state is GetHomeDataLoadingState || homeDataModelCubit == null) {
          return const CustomHomeShimmer();
        } else if (state is GetHomeDataErrorState) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                BannerWidget(banners: homeDataModelCubit.data?.banners),
                const SizedBox(height: 20),
                CustomListView(categoriesList: categoryCubit?.data ?? []),
                const SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'New Products',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ProductsGridView(
                      products: homeDataModelCubit.data?.products ?? [],
                      isInHome: true,
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          );
        }
      },
    );
  }
}
