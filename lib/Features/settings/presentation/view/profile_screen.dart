import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/settings/presentation/view_model/user%20cubit/user_cubit.dart';
import 'package:shop_api_app/core/widgets/custom_loading_indicator.dart';
import 'widgets/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userCubit = UserCubit.get(context);
         //nameController.text = userCubit.authModel?.data?.name ?? 'name null';
         //emailController.text =
         //    userCubit.authModel?.data?.email ?? 'email null';
         //phoneController.text =
         //    userCubit.authModel?.data?.phone ?? 'phone null';
          return ConditionalBuilder(
            condition:
                userCubit.authModel == null || state is UserloadingStates,
            builder: (BuildContext context) => const CustomLoadingIndicator(),
            fallback: (BuildContext context) => const ProfileScreenBody(),
          );
        },
      ),
    );
  }
}
