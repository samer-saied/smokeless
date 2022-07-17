import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freesmoking/core/app_color.dart';
import 'package:freesmoking/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';
import 'provider/service_provider.dart';

main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  runApp(EasyLocalization(
    startLocale: Locale('en', 'US'),
    saveLocale: true,
    useOnlyLangCode: true,
    supportedLocales: [
      Locale('en', 'US'),
      Locale('ar', 'EG'),
      Locale('de', 'DE'),
    ],
    path: 'assets/translations',
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppMainProvider()),
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'SmokeLess',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Palette.kToDark,
        unselectedWidgetColor: AppColors.main6Color,
      ),
      home: const LoginScreen(),
    );
  }
}
