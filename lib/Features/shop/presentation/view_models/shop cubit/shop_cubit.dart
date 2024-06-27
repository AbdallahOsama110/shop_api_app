import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../Categories/presentation/view/categories_screen.dart';
import '../../../../Home/presentation/view/home_screen.dart';
import '../../../../favorites/presentation/view/favorites_screen.dart';
import '../../../../settings/presentation/view/settings_screen.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currNavIndex = 0;

  List<Widget> bottomNavScreens = const [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeNavIndex(int index) {
    currNavIndex = index;
    emit(ShopButtomBarChange());
  }


  bool showpassword = true;
  IconData showPasswordIcon = FontAwesomeIcons.eyeSlash;
  void showPassword() {
    showpassword = !showpassword;
    showpassword
        ? showPasswordIcon = FontAwesomeIcons.eyeSlash
        : showPasswordIcon = FontAwesomeIcons.eye;
    emit(ShowPasswordState());
  }

  //! Theme Mode :
  bool isDark = true;
  Future<void> changeTheme(bool value) async {
    isDark = value;
    await CacheHelper.putData(key: 'isDark', value: isDark);
    emit(AppChangeThemeState());
  }
}
