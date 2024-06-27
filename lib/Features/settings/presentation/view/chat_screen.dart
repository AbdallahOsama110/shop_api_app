import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:crisp/crisp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../view_model/user cubit/user_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Shopee'),
      ),
      body: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var userCubit = UserCubit.get(context);
            return ConditionalBuilder(
              condition:
                  userCubit.authModel == null || state is UserloadingStates,
              builder: (BuildContext context) => const CustomLoadingIndicator(),
              fallback: (BuildContext context) => CrispView(
                crispMain: userCubit.crispMain,
                clearCache: false,
                //onLinkPressed: (url) {
                //  launch(url);
                //},
              ),
            );
          }),
    );
  }
}
