import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_api_app/Features/cart/presentation/view%20model/cart%20cubit/cart_cubit.dart';
import 'package:shop_api_app/Features/shop/presentation/view_models/shop%20cubit/shop_cubit.dart';
import 'package:sizer/sizer.dart';
import 'Features/home/data/repos/home_repo_impl.dart';
import 'Features/home/presentation/view_model/home cubit/home_cubit.dart';
import 'core/utils/app_router.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/consts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (cxt, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeCubit(HomeRepoImpl())),
            BlocProvider(create: (context) => CartCubit()),
            BlocProvider(
              create: (context) => ShopCubit()
                ..isDark = CacheHelper.getData(key: 'isDark') ?? false,
            ),
          ],
          child: BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                themeMode: ThemeMode.light,
                theme: ShopCubit.get(context).isDark
                    ? darkTheme().copyWith(
                        textTheme: GoogleFonts.montserratTextTheme(
                          darkTheme().textTheme,
                        ),
                      )
                    : lightTheme().copyWith(
                        textTheme: GoogleFonts.montserratTextTheme(
                          lightTheme().textTheme,
                        ),
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
