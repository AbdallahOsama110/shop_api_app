import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isEmail = false,
    this.isPassword = false,
    this.isPhone = false,
    this.isNotes = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isEmail;
  final bool isPassword;
  final bool isPhone;
  final bool isNotes;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit = ShopCubit.get(context);
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      obscureText: isPassword ? cubit.showpassword : false,
      obscuringCharacter: '●',
      style: Theme.of(context).textTheme.bodyMedium,
      /* style: TextStyle(
        color: Colors.white.withOpacity(.8),
        fontWeight: FontWeight.bold,
      ), */
      decoration: InputDecoration(
        filled: true,
        fillColor: cubit.isDark
            ? Colors.white.withOpacity(.12)
            : Colors.black.withOpacity(.12),
        constraints: BoxConstraints(
          minHeight: size.width / 8,
          maxWidth: size.width / 2.2,
        ),
        suffixIcon: Visibility(
          visible: isPassword,
          child: BlocBuilder<ShopCubit, ShopStates>(
            builder: (context, state) {
              return IconButton(
                onPressed: cubit.showPassword,
                icon: Icon(
                  cubit.showPasswordIcon,
                  color: Colors.black45,
                  size: 21,
                ),
              );
            },
          ),
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color:
                Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.5)),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> states) {
            final Color color = states.contains(WidgetState.error)
                ? Theme.of(context).colorScheme.error
                : Colors.black45;
            return Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: color);
          },
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
    );
  }
}
