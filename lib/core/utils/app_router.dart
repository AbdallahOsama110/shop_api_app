import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_api_app/Features/cart/presentation/view/thanks_view.dart';
import 'package:shop_api_app/Features/orders/presentation/view%20model/Orders%20cubit/orders_cubit.dart';
import 'package:shop_api_app/Features/orders/presentation/view/orders_view.dart';
import 'package:shop_api_app/Features/settings/presentation/view/chat_screen.dart';
import 'package:shop_api_app/Features/settings/presentation/view/location_screen.dart';
import 'package:shop_api_app/Features/settings/presentation/view/settings_screen.dart';
import 'package:shop_api_app/Features/settings/presentation/view_model/location%20cubit/location_cubit.dart';
import 'package:shop_api_app/Features/settings/presentation/view_model/user%20cubit/user_cubit.dart';
import '../../Features/Onboarding/presentation/view_models/Onboarding Cubit/onboarding_cubit.dart';
import '../../Features/Onboarding/presentation/views/onboarding_screen.dart';
import '../../Features/auth/presentation/view_model/auth%20cubit/auth_cubit.dart';
import '../../Features/auth/presentation/views/auth_screen.dart';
import '../../Features/cart/presentation/view/cart_screen.dart';
import '../../Features/search/presentation/view_models/Search Cubit/search_cubit.dart';
import '../../Features/search/presentation/views/search_screen.dart';
import '../../Features/settings/presentation/view/profile_screen.dart';
import '../../Features/shop/presentation/views/drawer/presentation/view/help_screen.dart';
import '../../Features/shop/presentation/views/drawer/presentation/view/information_screen.dart';
import '../../Features/shop/presentation/views/drawer/presentation/view/widgets/drawer_layout.dart';
import '../../Features/splash/presentation/views/splash_view.dart';
import 'cache_helper.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          final isFirstTimeOpen =
              CacheHelper.getData(key: 'isFirstTimeOpen') ?? true;
          final token = CacheHelper.getData(key: 'token');

          return isFirstTimeOpen
              ? const SplashScreen(nextScreen: '/onboarding')
              : SplashScreen(
                  nextScreen:
                      token == null || token.isEmpty ? '/login' : '/home',
                );
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => BlocProvider(
          create: (context) => OnboardingCubit(),
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const DrawerLayout(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const AuthScreen(),
        ),
      ),
      GoRoute(
        path: '/cartScreen',
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('Cart'),
            ),
            body: const CartScreen()),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => BlocProvider(
          create: (context) => SearchCubit(),
          child: const SearchScreen(),
        ),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpScreen(),
      ),
      GoRoute(
        path: '/information',
        builder: (context, state) => const InformationScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit()..getProfile(),
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit()..getChat(),
          child: const ChatScreen(),
        ),
      ),
      GoRoute(
        path: '/location',
        builder: (context, state) => BlocProvider(
          create: (context) => LocationCubit()..getAddresses(),
          child: const LocationScreen(),
        ),
      ),
      GoRoute(
        path: '/thanks',
        builder: (context, state) => const ThanksView(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => BlocProvider(
          create: (context) => OrdersCubit()..getOrders(),
          child: const OrdersView(),
        ),
      ),
    ],
  );
}
