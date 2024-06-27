import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_api_app/core/api/api_keys.dart';
import 'app.dart';
import 'core/api/api_service.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await ApiService.initDio();
  Stripe.publishableKey = ApiKeys.publishableKey;
  runApp(const MyApp());
}
