import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freesmoking/core/alert_dialog.dart';
import 'package:freesmoking/provider/app_provider.dart';
import 'package:freesmoking/provider/service_provider.dart';
import 'package:freesmoking/screens/ask/ask_screen.dart';
import 'package:freesmoking/screens/forget/forget_screen.dart';
import 'package:freesmoking/screens/home/widgets/home_screen_widgets.dart';
import 'package:freesmoking/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_color.dart';
import '../../models/user_model.dart';
import 'cards_widgets.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  void launchUrlFun() async {
    final Uri urlLink = Uri.parse('http://www.samersaied.me/');

    if (!await launchUrl(urlLink, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlLink';
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = context.read<ServicesProvider>().currentUserData;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSizedBox(true),
              ////////////////////////    TITLE (SETTINGS)    ////////////////////////////
              ///
              ////////////////////////    PROFILE    ////////////////////////////
              GetLargeProfileWidget(
                  size: MediaQuery.of(context).size.width - 20,
                  fontName: "Dosis",
                  txt: "User".tr(),
                  cardColor: AppColors.main2Color.withOpacity(0.7),
                  cardTxt: "2",
                  txtColor: AppColors.whiteColor,
                  isMore: false,
                  cardIcon: FontAwesomeIcons.solidUser,
                  tapFunc: () {
                    log("User card clicked");
                  },
                  cardColumnWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "${("Name").tr()} : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            "${user!.fName} ${user.lName}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "${("E-mail").tr()} : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            "${user.email}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "${("Age").tr()} : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            "${user.age} ${("Years").tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "${("Smoking state").tr()} : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            user.smoking.toString() == "true"
                                ? "Yes".tr()
                                : "No".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "${("From").tr()} : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            user.date!.getDate(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  )),
              getSizedBox(false),
              ////////////////////////    INFO   ////////////////////////////
              GetLargeProfileWidget(
                  size: MediaQuery.of(context).size.width - 20,
                  fontName: "Dosis",
                  txt: "Infomation".tr(),
                  isMore: true,
                  cardColor: AppColors.blueColor.withOpacity(0.7),
                  cardTxt: "2",
                  txtColor: AppColors.whiteColor,
                  cardIcon: FontAwesomeIcons.circleInfo,
                  tapFunc: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AskScreen(isSmoker: true)));
                  },
                  cardColumnWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "${("Number of Cigarettes Smoked Per Day").tr()} : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            "${user.cDaily} ${("cigarettes").tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            ("Number of cigarettes in a pack").tr() + " : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            "${user.cPNumber} ${("cigarettes").tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "${("cost of a pack of cigarettes").tr()} : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            "${user.cPPrice} ${("EGP").tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  )),
              getSizedBox(false),
              ////////////////////////    Settings    ////////////////////////////
              GetLargeProfileWidget(
                  size: (MediaQuery.of(context).size.width) - 20,
                  height: 100,
                  fontName: "Dosis",
                  txt: "Settings".tr(),
                  cardColor: AppColors.greenColor.withOpacity(0.7),
                  cardTxt: "2",
                  isMore: true,
                  txtColor: AppColors.whiteColor,
                  cardIcon: FontAwesomeIcons.gear,
                  tapFunc: () async {
                    if (context.locale.languageCode == 'ar') {
                      await alertDialogWidget(
                              context,
                              "Are you want to change language to".tr(),
                              "English".tr(),
                              2)
                          .then((value) {
                        value ? context.setLocale(Locale('en', 'US')) : null;
                      });
                    } else {
                      await alertDialogWidget(
                              context,
                              "Are you want to change language to".tr(),
                              "Arabic".tr(),
                              2)
                          .then((value) {
                        value ? context.setLocale(Locale('ar', 'EG')) : null;
                      });
                    }
                  },
                  cardColumnWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getSizedBox(false),
                      Wrap(
                        children: [
                          Text(
                            "Language : ",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                          Text(
                            context.locale.languageCode == 'ar'
                                ? "العربيه"
                                : "English",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                ),
                          ),
                        ],
                      ),
                      getSizedBox(false),
                      Text(
                        "${("Currency").tr()} : ${("EGP").tr()}",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "* click to switch languages".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: AppColors.main4Color,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              getSizedBox(false),
              ////////////////////////    ACCOUNT    ////////////////////////////
              GetLargeProfileWidget(
                  size: (MediaQuery.of(context).size.width) - 20,
                  height: 100,
                  fontName: "Dosis",
                  txt: "Account".tr(),
                  isMore: false,
                  cardColor: AppColors.mainColor.withOpacity(0.7),
                  cardTxt: "2",
                  txtColor: AppColors.whiteColor,
                  cardIcon: FontAwesomeIcons.solidUser,
                  tapFunc: () {},
                  cardColumnWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getSizedBox(false),
                      InkWell(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgetScreen()));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Forget password".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: AppColors.whiteColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      getSizedBox(false),
                      InkWell(
                        onTap: () async {
                          alertDialogWidget(context, "Confirm".tr(),
                                  "Are you sure to delete your account".tr(), 2)
                              .then((value) async {
                            ////////////////
                            ///
                            ///           EDIT
                            ///
                            ///
                            if (value) {
                              if (FirebaseAuth.instance.currentUser != null) {
                                context
                                    .read<ServicesProvider>()
                                    .currentUserData = null;
                                User user = FirebaseAuth.instance.currentUser!;
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user.uid)
                                    .delete();
                                await user.delete().then((value) {
                                  context
                                      .read<AppMainProvider>()
                                      .selectedIndex = 0;
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                });
                              }
                            } else {}
                          });

                          // await context.read<ServicesProvider>().userUID.delete();
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Delete Account".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: AppColors.whiteColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              getSizedBox(false),
              ////////////////////////    ABOUT    ////////////////////////////
              getSizedBox(false),
              GetLargeProfileWidget(
                  size: MediaQuery.of(context).size.width - 20,
                  fontName: "Dosis",
                  txt: "About".tr(),
                  cardColor: AppColors.main7Color,
                  cardTxt: "2",
                  txtColor: AppColors.whiteColor,
                  cardIcon: FontAwesomeIcons.dev,
                  isMore: true,
                  tapFunc: () {
                    launchUrlFun();
                  },
                  cardColumnWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getSizedBox(false),
                      Center(
                        child: Text(
                          "wwww.samersaied.me",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: AppColors.whiteColor,
                              ),
                        ),
                      ),
                    ],
                  )),
              getSizedBox(true),
            ],
          ),
        ),
      ),
    );
  }
}
