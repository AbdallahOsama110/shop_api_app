import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/view/product details/view/product_details_screen.dart';
import '../../../home/presentation/view_model/home cubit/home_cubit.dart';
import 'widgets/search_screen_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetProductDetailsSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                product: HomeCubit.get(context).productDetailsModel?.data,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(child: SearchScreenBody()),
        );
      },
    );
  }
}
