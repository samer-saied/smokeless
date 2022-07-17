import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freesmoking/core/app_color.dart';
import 'package:freesmoking/provider/app_provider.dart';
import 'package:provider/provider.dart';

Widget appBottomBarWidget(BuildContext context) {
  return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.info),
          label: 'Reports'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.solidRectangleList),
          label: 'More'.tr(),
        ),
      ],
      currentIndex: context.watch<AppMainProvider>().selectedIndex,
      selectedItemColor: AppColors.whiteColor,
      onTap: (newValue) {
        Provider.of<AppMainProvider>(context, listen: false)
            .changeIndex(newValue);
      },
      backgroundColor: AppColors.darkgeryColor,
      unselectedItemColor: AppColors.geryColor
      // elevation: 0,
      );
}
