import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Features/cart/data/models/payment_method_model/payment_method_model.dart';

const kPrimaryColor3 = Colors.white;
const kPrimaryColor2 = Color(0xff100B20);
const kPrimaryColor = Colors.white;
const scaffoldBackgroundColorDark = Color(0xff192028);
const scaffoldBackgroundColorLight = Color(0xFFE7ECEF);
var lightDrawerColor = Colors.grey.shade300;
const darktDrawerColor = Color.fromARGB(255, 17, 17, 17);
var darkshadowDrawerColor2 = Colors.grey.shade600.withOpacity(0.9);
var lightshadowDrawerColor2 = Colors.white.withOpacity(0.7);

const image1 = 'assets/images/onboarding4.png';
const image2 = 'assets/images/onboarding2.png';
const image3 = 'assets/images/onboarding3.png';

enum ToastType { success, error, other }

class AssetsData {
  static const logo = 'assets/images/Logo.png';
  static const book1 = 'assets/images/Book 1 Hightligh.png';
  static const book2 = 'assets/images/bat_man.png';
  static const book3 = 'assets/images/book.png';
}

List<PaymentMethodModel> paymentMethodsList = [
  PaymentMethodModel(
    id: 1,
    methodName: 'Card',
    methodImage: 'assets/images/card.svg',
    paymentMethod: '2',
  ),
  PaymentMethodModel(
    id: 2,
    methodName: 'Paypal',
    methodImage: 'assets/images/paypal.svg',
    paymentMethod: '2',
  ),
  PaymentMethodModel(
    id: 3,
    methodName: 'Cash',
    methodImage: 'assets/images/cash.png',
    paymentMethod: '1',
  ),
];

const webId = 'dca733ed-f290-4be9-8a3b-f057342bf647';
const nullImage =
    'https://static.vecteezy.com/system/resources/previews/000/677/302/non_2x/abstract-technology-banner-background.jpg';

abstract class Styles {
  static const textStyle30 = TextStyle(
      fontSize: 30, fontWeight: FontWeight.normal, fontFamily: 'GT-Sectra');
  static const textStyle20 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const textStyle18 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white);
  static const textStyle16 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

  static const textStyle14 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
}

/* headlineMedium: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: ColorName.onboardingHead,
          fontSize: 29.sp,
          fontWeight: FontWeight.w700,
          height: 1.26,
        ),
      ),
      headlineSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      titleLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
      titleMedium: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: ColorName.onboardingSub,
        ),
      ),
      titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      bodyMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ), */

const kTranstionDuration = Duration(milliseconds: 250);

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      //! FS 30
      headlineMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.26,
      ),
      //! FS 25
      headlineSmall: TextStyle(
        fontSize: 18.25.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(.8),
      ),
      //! FS 20
      titleLarge: TextStyle(
        fontSize: 14.6.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(.8),
      ),
      bodyLarge: TextStyle(
        fontSize: 14.6.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(.8),
      ),
      //! Fs 18
      bodyMedium: TextStyle(
        fontSize: 14.25.sp,
        height: 1.3,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      //! FS 14
      bodySmall: TextStyle(
        fontSize: 10.25.sp,
        height: 1.3,
        color: Colors.white,
      ),
      //! FS 13
      labelLarge: TextStyle(
        fontSize: 9.5.sp,
        height: 1.3,
        color: Colors.grey,
      ),
      //! FS 10
      labelMedium: TextStyle(
        fontSize: 7.3.sp,
        height: 1.3,
        color: Colors.white,
      ),
      //! FS 9
      labelSmall: TextStyle(
        fontSize: 6.5.sp,
        height: 1.3,
        color: Colors.grey,
      ),
    ),
    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    iconTheme: const IconThemeData(color: Colors.white),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: scaffoldBackgroundColorLight,
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      surfaceTintColor: scaffoldBackgroundColorDark,
      backgroundColor: scaffoldBackgroundColorDark,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.green,
      //selectionColor: ColorName.onboardingSub,
      selectionHandleColor: Colors.green,
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      //! FS 30
      headlineMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.26,
      ),
      //! FS 25
      headlineSmall: TextStyle(
        fontSize: 18.25.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(.8),
      ),
      //! FS 20
      titleLarge: TextStyle(
        fontSize: 14.6.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black.withOpacity(.8),
      ),
      //! FS 20
      bodyLarge: TextStyle(
        fontSize: 14.6.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(.8),
      ),
      //! Fs 18
      bodyMedium: TextStyle(
        fontSize: 14.25.sp,
        height: 1.3,
        color: scaffoldBackgroundColorDark,
        fontWeight: FontWeight.w500,
      ),
      //! FS 14
      bodySmall: TextStyle(
        fontSize: 10.25.sp,
        height: 1.3,
        color: scaffoldBackgroundColorDark,
        fontWeight: FontWeight.bold,
      ),
      //! FS 13
      labelLarge: TextStyle(
        fontSize: 9.5.sp,
        height: 1.3,
        color: scaffoldBackgroundColorDark,
        fontWeight: FontWeight.bold,
      ),
      //! FS 10
      labelMedium: TextStyle(
        fontSize: 7.3.sp,
        height: 1.3,
        color: scaffoldBackgroundColorDark,
        fontWeight: FontWeight.bold,
      ),
      //! FS 9
      labelSmall: TextStyle(
        fontSize: 6.5.sp,
        height: 1.3,
        color: scaffoldBackgroundColorDark,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    iconTheme: const IconThemeData(color: scaffoldBackgroundColorDark),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(scaffoldBackgroundColorDark),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: scaffoldBackgroundColorDark,
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      surfaceTintColor: scaffoldBackgroundColorLight,
      backgroundColor: scaffoldBackgroundColorLight,
      foregroundColor: scaffoldBackgroundColorDark,
      /* titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black,
      ), */
      iconTheme: IconThemeData(color: scaffoldBackgroundColorDark),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: scaffoldBackgroundColorDark),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.green,
      //selectionColor: ColorName.onboardingSub,
      selectionHandleColor: Colors.green,
    ),
  );
}
