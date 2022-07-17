import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_bottombar.dart';
import '../core/app_color.dart';
import '../provider/app_provider.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  // bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    // remainTime = context.watch<ServicesProvider>().getRemainingTime(2020, 7, 5);
    // double size = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      bottomNavigationBar: appBottomBarWidget(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.2,
                image: AssetImage(
                  "assets/images/background.jpg",
                ),
                fit: BoxFit.cover)),
        child: context.watch<AppMainProvider>().getCurrentScreen(),
      ),
    );
  }
}
