import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freesmoking/provider/service_provider.dart';
import 'package:provider/provider.dart';

import '../../core/app_color.dart';
import '../ask/ask_screen.dart';
import '../home/widgets/home_screen_widgets.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> remainTime = {};
    ServicesProvider servicesProvider = context.watch<ServicesProvider>();
    double widthScreen = MediaQuery.of(context).size.width - 30;

    double getPeriod() {
      double period = 0.0;
      remainTime = servicesProvider.getRemainingTime(
        int.parse(servicesProvider.currentUserData!.date!.years ?? '0'),
        int.parse(servicesProvider.currentUserData!.date!.months ?? '0'),
        int.parse(servicesProvider.currentUserData!.date!.days ?? '0'),
      );
      period = double.parse(servicesProvider.currentUserData!.nYS ?? '0') +
          double.parse(remainTime['years'].toString());
      if (period * 5 >= 150) {
        return 120.0;
      } else {
        return period * 5;
      }
    }

    double lossTime = getPeriod();

    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /////////               SMOKING TRUE         /////////
            servicesProvider.isSmoking == true
                ? Row(
                    children: [
                      Wrap(alignment: WrapAlignment.start, children: [
                        Text(
                          "Lost of health :".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 24,
                                color: AppColors.whiteColor,
                              ),
                        ),
                      ]),
                    ],
                  )
                : const SizedBox(),
            getSizedBox(false),
            servicesProvider.isSmoking == true
                ? getLungsWidget(lossTime)
                : const SizedBox(),
            getSizedBox(false),
            /////////               HEALTH         /////////
            servicesProvider.isSmoking == false
                ? getHealthyCards(
                    context, widthScreen, remainTime, servicesProvider)
                : getSmokingCards(context, widthScreen, servicesProvider)
          ],
        ),
      ),
    ));
  }

  ///
  ///
  ///
///////////////////////     WIDGETS   ///////////////////////////
  Widget getLungsWidget(double lossTime) {
    return Stack(children: [
      SizedBox(
        height: 200,
        width: 200,
        child: AspectRatio(
          aspectRatio: 320 / 100,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: FractionalOffset.bottomCenter,
              image: AssetImage('assets/images/Lung.png'),
            )),
          ),
        ),
      ),
      SizedBox(
          height: 200,
          width: 200,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
              ////////////
              ///
              ///
              ///
              ///
              height: lossTime,
              width: 200,
              child: AspectRatio(
                aspectRatio: 20 / 20,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.bottomCenter,
                    image: AssetImage('assets/images/Lung_black.png'),
                  )),
                ),
              ),
            ),
          ]))
    ]);
  }

  Widget getSmokingCards(BuildContext context, double widthScreen,
      ServicesProvider servicesProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        getSizedBox(false),
        //////////// LOST OF MONEY  ///////////////
        Row(
          children: [
            Wrap(alignment: WrapAlignment.start, children: [
              Text(
                "Lost of money:".tr(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                      color: AppColors.whiteColor,
                    ),
              ),
            ]),
          ],
        ),
        getSizedBox(false),
        ////////////  Cost CARD  ///////////////
        GetLargeCardWidget(
          size: widthScreen,
          fontName: "Dosis",
          txt: "Cost".tr(),
          cardColor: AppColors.blueColor.withOpacity(0.8),
          cardTxt: "2",
          txtColor: AppColors.whiteColor,
          cardIcon: FontAwesomeIcons.moneyBillTrendUp,
          cardColumnWidget: servicesProvider.costDay == 0.0
              ? InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.triangleExclamation,
                          color: AppColors.whiteColor),
                      GetCustomTxtWidget(
                        txt: "More information to get Cost,".tr(),
                        sizeTxt: 12,
                        isBold: false,
                      ),
                      GetCustomTxtWidget(
                        txt: "Update now.".tr(),
                        sizeTxt: 12,
                        isBold: false,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AskScreen(isSmoker: servicesProvider.isSmoking)));
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weekly cost:".tr() +
                          "${servicesProvider.formatNumber(7.0 * servicesProvider.costDay)}" +
                          "EGP".tr(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    Text(
                      "Monthly cost: " +
                          "${servicesProvider.formatNumber(30.0 * double.parse(servicesProvider.costDay.toString()))}" +
                          "EGP".tr(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    Text(
                      "Yearly cost:" +
                          "  ${servicesProvider.formatNumber(365 * servicesProvider.costDay)} " +
                          "EGP".tr(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget getHealthyCards(BuildContext context, double widthScreen,
      Map<String, int> remainTime, ServicesProvider servicesProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ////////////  TITLE OF LARGE CARDS  ///////////////
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(FontAwesomeIcons.award, color: AppColors.whiteColor),
            ),
            Wrap(alignment: WrapAlignment.start, children: [
              Text(
                "Benefits :".tr(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: AppColors.whiteColor,
                    ),
              ),
            ]),
          ],
        ),
        getSizedBox(false),
        ////////////  Money CARD  ///////////////
        GetLargeCardWidget(
          size: widthScreen,
          fontName: "Dosis",
          txt: "Money".tr(),
          cardColor: AppColors.main2Color.withOpacity(0.8),
          cardTxt: "2",
          txtColor: AppColors.whiteColor,
          cardIcon: FontAwesomeIcons.sackDollar,
          cardColumnWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: unnecessary_null_comparison
              (remainTime != null)
                  ? Text(
                      "Saved until now:".tr() +
                          " ${(servicesProvider.formatNumber(servicesProvider.collectDays(remainTime) * (servicesProvider.costDay)))} " +
                          "EGP".tr(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        ////////////  SAVE MONEY CARD  ///////////////
        GetLargeCardWidget(
          size: widthScreen,
          fontName: "Dosis",
          txt: "Save".tr(),
          cardColor: AppColors.blueColor.withOpacity(0.8),
          cardTxt: "2",
          txtColor: AppColors.whiteColor,
          cardIcon: FontAwesomeIcons.handHoldingDollar,
          cardColumnWidget: servicesProvider.costDay == 0.0
              ? InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.triangleExclamation,
                          color: AppColors.whiteColor),
                      GetCustomTxtWidget(
                        txt: "More information to get Cost,".tr(),
                        sizeTxt: 12,
                        isBold: false,
                      ),
                      GetCustomTxtWidget(
                        txt: "Update now.".tr(),
                        sizeTxt: 12,
                        isBold: false,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AskScreen(isSmoker: servicesProvider.isSmoking)));
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weekly save:".tr() +
                          " ${servicesProvider.formatNumber(7.0 * (servicesProvider.costDay))} " +
                          "EGP".tr(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    Text(
                      "Monthly save:".tr() +
                          "  ${servicesProvider.formatNumber(30 * (servicesProvider.costDay))} " +
                          "EGP".tr(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    Text(
                      "Yearly save:".tr() +
                          "  ${servicesProvider.formatNumber(365 * (servicesProvider.costDay))} " +
                          "EGP".tr(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ],
                ),
        ),
        ////////////  Heart CARD  ///////////////
        GetLargeCardWidget(
          size: widthScreen,
          fontName: "Dosis",
          txt: "Heart".tr(),
          cardColor: AppColors.mainColor.withOpacity(0.8),
          cardTxt: "4",
          txtColor: AppColors.whiteColor,
          cardIcon: FontAwesomeIcons.heartCircleBolt,
          // ignore: unnecessary_null_comparison
          cardColumnWidget: remainTime != null
              ? Text(
                  "heart health:".tr() +
                      " ${servicesProvider.gainHeartRate(remainTime)}%",
                  softWrap: true,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: AppColors.whiteColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                )
              : const SizedBox(),
        ),
        ////////////  LIFE CARD  ///////////////
        GetLargeCardWidget(
          size: widthScreen,
          fontName: "Dosis",
          txt: "Life".tr(),
          cardColor: AppColors.main7Color.withOpacity(0.8),
          cardTxt: "6",
          txtColor: AppColors.whiteColor,
          cardIcon: FontAwesomeIcons.starOfLife,
          cardColumnWidget: Text(
            "Expected Life:".tr() +
                "\n ${servicesProvider.gainExpectedTime(remainTime)}",
            softWrap: true,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: AppColors.whiteColor,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
      ],
    );
  }
}
