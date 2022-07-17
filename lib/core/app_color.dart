import 'package:flutter/material.dart';

class AppColors {
  static Color mainColor = const Color.fromARGB(255, 171, 39, 53);
  static Color main1Color = const Color(0xFF353535);
  static Color main2Color = const Color(0xFF3c6e71);
  static Color main3Color = const Color(0xFFfdfcdc);

  static Color main4Color = const Color(0xFFf2cc8f);
  static Color main5Color = const Color(0xFFe0e1dd);
  static Color main6Color = const Color(0xFF26364F);
  static Color blueColor = const Color(0xFF26364F);
  static Color main7Color = const Color(0xFF489fb5);
  static Color main8Color = const Color.fromARGB(255, 255, 174, 130);
  static Color heartColor = const Color(0xFFf694c1);
  static Color greenColor = const Color(0xFFBF936A);
  static Color whiteColor = const Color(0xFFffffff);
  static Color blackColor = const Color.fromARGB(255, 0, 0, 0);
  static Color geryColor = const Color.fromARGB(255, 165, 165, 165);
  static Color darkgeryColor = const Color.fromARGB(255, 35, 35, 35);
}

class Palette {
  static MaterialColor kToDark = MaterialColor(
    0xFF26364F, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: AppColors.blueColor, //10%
      100: AppColors.blueColor, //20%
      200: AppColors.blueColor, //30%
      300: AppColors.blueColor, //40%
      400: AppColors.blueColor, //50%
      500: AppColors.blueColor, //60%
      600: AppColors.blueColor, //70%
      700: AppColors.blueColor, //80%
      800: AppColors.blueColor, //90%
      900: AppColors.blueColor, //100%
    },
  );
}
