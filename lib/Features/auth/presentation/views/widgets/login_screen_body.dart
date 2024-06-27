/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/consts/consts.dart';
import '../../../../../core/functions/toast_message.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../view_model/auth cubit/auth_cubit.dart';
import '../../view_model/auth cubit/auth_states.dart';
import 'custom_text_form_field.dart';

class LogInScreenBody extends StatelessWidget {
  const LogInScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginError) {
          if (state.error == 'user-not-found') {
            toastMessage(context,
                msg: 'No user found for that email!', type: ToastType.error);
          } else if (state.error == 'wrong-password') {
            toastMessage(context,
                msg: 'Wrong password provided for that user!',
                type: ToastType.error);
          }
        }
      },
      builder: (context, state) {
        //! var cubit = AuthCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * .071),
                  CustomTextFormField(
                      isEmail: true,
                      labelText: 'Email address',
                      controller: emailcontroller),
                  SizedBox(height: size.height * .054),
                  CustomTextFormField(
                      isPassword: true,
                      labelText: 'Password',
                      controller: passwordcontroller),
                  SizedBox(height: size.height * .071),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {}
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
 */