import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freesmoking/provider/service_provider.dart';
import 'package:provider/provider.dart';

import '../../core/app_color.dart';
import 'widgets/home_screen_widgets.dart';

///
///
///
/////////////       HOMEPAGE WIDGET     ////////////////
// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  bool isPressed = false;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width - 30;
    print("=========================rebuild=========================");
    ServicesProvider servicesProvider = context.read<ServicesProvider>();
    servicesProvider.getUserData(false);
    servicesProvider.getAdvice(isSmoke: servicesProvider.isSmoking);
    // servicesProvider.addAdvice();
    // servicesProvider.addAdvice();
//
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              /////////               APPBAR && BIG BUTTON        /////////
              Consumer<ServicesProvider>(builder: ((context, provider, child) {
                if (provider.currentUserData == null) {
                  return AppBarWidget(userName: "user".tr());
                } else {}
                return Column(
                  children: [
                    AppBarWidget(
                        userName: servicesProvider.currentUserData!.fName
                            .toString()
                            .toUpperCase()),
                    getSizedBox(false),
                    provider.isSmoking == true
                        ? GetMainCustomButton(
                            isPressed: false,
                          )
                        : GetMainCustomButton(isPressed: true),
                  ],
                );
              })),
              /////////               ADVICE        /////////
              Consumer<ServicesProvider>(
                builder: ((context, provider, child) {
                  return Column(children: [
                    getSizedBox(true),
                    Row(
                      children: [
                        GetCustomTxtWidget(
                            txt: "Today's Advice".tr(),
                            sizeTxt: 24,
                            isBold: true),
                      ],
                    ),
                    getSizedBox(false),
                    servicesProvider.advice == null
                        ? const CircularProgressIndicator()
                        : GetMainCardWidget(
                            size: widthScreen,
                            fontName: "Dosis",
                            txt: "${provider.advice!.by}",
                            cardColor: AppColors.darkgeryColor.withOpacity(0.8),
                            fontSize: 26,
                            cardTxt: provider.advice!.data.toString(),
                            txtColor: AppColors.whiteColor,
                          ),
                  ]);
                }),
              ),
              /////////               FREE SMOKING        /////////
              Consumer<ServicesProvider>(
                builder: ((context, provider, child) {
                  return Column(children: [
                    getSizedBox(false),
                    FreeSmokingCounterWidget(
                      isSmoking: provider.isSmoking,
                    )
                    // : const SizedBox(),
                  ]);
                }),
              ),
            ])),
      ),
    );
  }
}

///
///
///
/////////////       FREE SMOKING WIDGET     ////////////////
class FreeSmokingCounterWidget extends StatelessWidget {
  final bool? isSmoking;
  const FreeSmokingCounterWidget({
    Key? key,
    required this.isSmoking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServicesProvider prodiver = context.read<ServicesProvider>();
    double widthScreen = MediaQuery.of(context).size.width - 45;
    if (prodiver.currentUserData == null) {
      return const CircularProgressIndicator();
    } else {
      int years = int.parse(prodiver.currentUserData!.date!.years.toString());
      int months = int.parse(prodiver.currentUserData!.date!.months!);
      int days = int.parse(prodiver.currentUserData!.date!.days!);
      Map<String, int> remainTime =
          prodiver.getRemainingTime(years, months, days);
      if (isSmoking == false) {
        return Column(
          children: [
            getSizedBox(false),
            Row(
              children: [
                Wrap(alignment: WrapAlignment.start, children: [
                  Text(
                    "Free smoking for :".tr(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColors.whiteColor,
                        ),
                  ),
                ]),
              ],
            ),
            getSizedBox(false),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ////////////  YEARS  ///////////////
                  GetMainCardWidget(
                    size: widthScreen / 3,
                    fontName: "Dosis",
                    txt: "Years".tr(),
                    cardColor: AppColors.main2Color.withOpacity(0.8),
                    cardTxt: remainTime['years'].toString(),
                    txtColor: AppColors.whiteColor,
                    tilefontSize: 30,
                  ),
                  ////////////  MONTHS  ///////////////
                  GetMainCardWidget(
                    size: widthScreen / 3,
                    fontName: "Dosis",
                    txt: "Months".tr(),
                    cardColor: AppColors.mainColor.withOpacity(0.8),
                    cardTxt: remainTime['months'].toString(),
                    txtColor: AppColors.whiteColor,
                    tilefontSize: 30,
                  ),
                  ////////////  DAYS  ///////////////
                  GetMainCardWidget(
                    size: widthScreen / 3,
                    fontName: "Dosis",
                    txt: "Days".tr(),
                    cardColor: AppColors.blueColor.withOpacity(0.8),
                    cardTxt: remainTime['days'].toString(),
                    txtColor: AppColors.whiteColor,
                    tilefontSize: 30,
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    }
  }
}
