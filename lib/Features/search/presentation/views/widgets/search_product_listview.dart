import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_api_app/Features/home/presentation/view_model/home%20cubit/home_cubit.dart';
import 'package:shop_api_app/Features/search/data/models/search_model/search_product_data.dart';
import 'package:shop_api_app/Features/search/presentation/view_models/Search%20Cubit/search_state.dart';
import '../../view_models/Search Cubit/search_cubit.dart';

class SearchProductsListView extends StatelessWidget {
  const SearchProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        var searchCubit = SearchCubit.get(context).searchModel;
        if (searchCubit != null && state is SearchSuccess) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: searchCubit.data?.data?.length ?? 0,
            itemBuilder: (context, index) => ProductSearchItem(
              product: searchCubit.data?.data?[index],
              index: index,
              length: searchCubit.data?.data?.length ?? 0,
            ),
          );
        } else if (state is SearchLoading) {
          return Column(
            children: [
              LinearProgressIndicator(
                color: Colors.green[500],
                backgroundColor: Colors.green[200],
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class ProductSearchItem extends StatelessWidget {
  const ProductSearchItem({
    super.key,
    required this.product,
    required this.index,
    required this.length,
  });
  final SearchProductData? product;
  final int index;
  final int length;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            HomeCubit.get(context)
                .getProductDetailsById(productId: product?.id ?? 52);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: size.width * .12,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: size.width * .0425,
                      color: Colors.grey,
                    ),
                    SizedBox(width: size.width * .04),
                    SizedBox(
                      width: size.width * .77,
                      child: Text(
                        product?.name ?? 'name',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.north_west_rounded,
                      size: size.width * .06,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              if (index != length - 1)
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
            ],
          ),
        );
      },
    );
  }
}
