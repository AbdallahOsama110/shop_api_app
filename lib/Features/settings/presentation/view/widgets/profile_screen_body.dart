import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/toast_message.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../auth/presentation/views/widgets/text_field_pro.dart';
import '../../view_model/user cubit/user_cubit.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userCubit = UserCubit.get(context);
        nameController.text = userCubit.authModel?.data?.name ?? 'name null';
        emailController.text = userCubit.authModel?.data?.email ?? 'email null';
        phoneController.text = userCubit.authModel?.data?.phone ?? 'phone null';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: MediaQuery.sizeOf(context).width * .18,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      const AssetImage('assets/images/erin_yeager.jpeg'),
                ),
                const SizedBox(height: 20),
                CustomTextFormFieldPro(
                  controller: nameController,
                  hintText: 'UserName',
                  /* color: ShopCubit.get(context).isDark
                      ? Colors.white
                      : Colors.grey.withOpacity(.4), */
                ),
                const SizedBox(height: 10),
                CustomTextFormFieldPro(
                  controller: emailController,
                  hintText: 'Email',
                  isEmail: true,
                  /* color: ShopCubit.get(context).isDark
                      ? Colors.white
                      : Colors.grey.withOpacity(.4), */
                ),
                const SizedBox(height: 10),
                CustomTextFormFieldPro(
                  controller: phoneController,
                  hintText: 'Phone',
                  isPhone: true,
                  /* color: ShopCubit.get(context).isDark
                      ? Colors.white
                      : Colors.grey.withOpacity(.4), */
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Edit Profile',
                  overlayColor: Colors.greenAccent,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? true) {
                      if (nameController.text ==
                              userCubit.authModel?.data?.name &&
                          emailController.text ==
                              userCubit.authModel?.data?.email &&
                          phoneController.text ==
                              userCubit.authModel?.data?.phone) {
                        toastMessage(
                            msg: 'there is no change to edit',
                            type: ToastType.other);
                      } else {
                        userCubit.updateProfile(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
