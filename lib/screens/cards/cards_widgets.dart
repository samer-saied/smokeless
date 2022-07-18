import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freesmoking/core/app_color.dart';
import 'package:freesmoking/screens/home/widgets/home_screen_widgets.dart';

// ignore: must_be_immutable
class GetLargeProfileWidget extends StatelessWidget {
  GetLargeProfileWidget({
    Key? key,
    required this.size,
    required this.txt,
    required this.cardColor,
    required this.cardTxt,
    required this.txtColor,
    required this.fontName,
    required this.cardIcon,
    required this.cardColumnWidget,
    required this.isMore,
    this.fontSize,
    this.height,
    this.tapFunc,
  }) : super(key: key);

  final double size;
  double? height;
  final String txt;
  final Color cardColor;
  final String cardTxt;
  final Color txtColor;
  final String fontName;
  final IconData cardIcon;
  final Widget cardColumnWidget;
  final void Function()? tapFunc;
  final bool isMore;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    print(context.locale.toString());
    return InkWell(
      onTap: tapFunc,
      child: IntrinsicHeight(
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: (context.locale.toString() == "ar_EG")
                        ? BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                    // gradient: RadialGradient(
                    //   radius: 2,
                    //   colors: [
                    //     cardColor,
                    //     Colors.transparent,
                    //     cardColor,
                    //   ],
                    //   // begin: Alignment.topLeft,
                    //   // end: Alignment.bottomRight,
                    // ),
                  ),
                ),
              ),
              Expanded(
                flex: 14,
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size * 0.80,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    cardIcon,
                                    color: cardColor,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GetCustomTxtWidget(
                                    txt: txt,
                                    sizeTxt: 22,
                                    isBold: true,
                                    txtColor: AppColors.whiteColor,
                                  ),
                                ],
                              ),
                              getSizedBox(false),
                              Divider(
                                height: 1,
                                color: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                        cardColumnWidget,
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: isMore
                        ? Icon(
                            context.locale.languageCode == 'ar'
                                ? FontAwesomeIcons.chevronLeft
                                : FontAwesomeIcons.chevronRight,
                            color: AppColors.whiteColor,
                          )
                        : SizedBox(),
                  ),
                  decoration: BoxDecoration(
                    color: isMore ? cardColor : Colors.black.withOpacity(0.2),
                    borderRadius: (context.locale.toString() == "ar_EG")
                        ? BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                    // gradient: RadialGradient(
                    //   radius: 2,
                    //   colors: [
                    //     cardColor,
                    //     Colors.transparent,
                    //     cardColor,
                    //   ],
                    //   // begin: Alignment.topLeft,
                    //   // end: Alignment.bottomRight,
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
