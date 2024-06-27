import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/custom_color_selection_handle.dart';
import '../../../../shop/presentation/view_models/shop cubit/shop_cubit.dart';

class CustomTextFormFieldPro extends StatelessWidget {
  const CustomTextFormFieldPro({
    super.key,
    required this.hintText,
    this.isEmail = false,
    this.isPassword = false,
    this.isPhone = false,
    required this.controller,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isEmail;
  final bool isPassword;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit = ShopCubit.get(context);
    return TextSelectionTheme(
      data: const TextSelectionThemeData(
        cursorColor: Colors.purple,
        selectionHandleColor: Colors.purple,
      ),
      child: TextFormField(
        controller: controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        selectionControls: CustomColorSelectionHandle(Colors.purple),
        style: Theme.of(context).textTheme.bodySmall,
        cursorColor: Colors.purple,
        obscureText: isPassword ? cubit.showpassword : false,
        obscuringCharacter: '●',
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isPhone
                ? TextInputType.number
                : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: ShopCubit.get(context).isDark
              ? Colors.white.withOpacity(.12)
              : Colors.grey.withOpacity(.4),
          constraints: BoxConstraints(
            minHeight: size.width / 8,
            maxWidth: size.width / 1.2,
          ),
          prefixIcon: Icon(
            isEmail
                ? Icons.email_outlined
                : isPassword
                    ? Icons.lock_outline
                    : isPhone
                        ? Icons.phone
                        : Icons.account_circle_outlined,
            color: ShopCubit.get(context).isDark
                ? Colors.white.withOpacity(.7)
                : Colors.black.withOpacity(.7),
          ),
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          /* TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)), */
          suffixIcon: Visibility(
            visible: isPassword,
            child: BlocBuilder<ShopCubit, ShopStates>(
              builder: (context, state) {
                return IconButton(
                  onPressed: cubit.showPassword,
                  icon: Icon(
                    cubit.showPasswordIcon,
                    color: ShopCubit.get(context).isDark
                        ? Colors.white.withOpacity(.7)
                        : Colors.black.withOpacity(.7),
                    size: 18,
                  ),
                );
              },
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) {
          if (value == null || value == '') {
            return 'Enter $hintText';
          } else if (!RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                  .hasMatch(value) &&
              isEmail) {
            return 'Enter valid email';
          } else if (isPassword && value.length < 6) {
            return 'Weak Password';
          } else if (isPhone && value.length != 11) {
            return 'Wrong Phone Pumber';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
