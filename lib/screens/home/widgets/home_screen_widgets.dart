import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freesmoking/core/alert_dialog.dart';
import 'package:freesmoking/provider/service_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/app_color.dart';
import '../../login/login_screen.dart';

Widget getSizedBox(bool isDouble) {
  if (isDouble == false) {
    return const SizedBox(
      height: 10,
    );
  } else {
    return const SizedBox(
      height: 20,
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final String userName;
  const AppBarWidget({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Welcome ".tr(),
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: AppColors.whiteColor,
                  ),
            ),
            Text(
              userName,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: AppColors.whiteColor,
                  ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.arrowUpRightFromSquare),
          color: AppColors.whiteColor,
          onPressed: () {
            context.read<ServicesProvider>().signOut().then((value) {
              final navigator = Navigator.of(context); // store the Navigator
              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            });
          },
        )
      ],
    );
  }
}

class GetCustomTxtWidget extends StatelessWidget {
  final String txt;
  final double sizeTxt;
  final bool isBold;
  final Color? txtColor;
  const GetCustomTxtWidget({
    Key? key,
    required this.txt,
    required this.sizeTxt,
    required this.isBold,
    this.txtColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      softWrap: true,
      // maxLines: 2,
      // overflow: TextOverflow.clip,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: sizeTxt,
            color: txtColor ?? AppColors.whiteColor,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}

// ignore: must_be_immutable
class GetMainCardWidget extends StatelessWidget {
  GetMainCardWidget({
    Key? key,
    required this.size,
    required this.txt,
    required this.cardColor,
    required this.cardTxt,
    required this.txtColor,
    required this.fontName,
    this.fontSize,
    this.tilefontSize,
  }) : super(key: key);

  final double size;
  final String txt;
  final Color cardColor;
  final String cardTxt;
  final Color txtColor;
  final String fontName;

  double? fontSize;
  double? tilefontSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 3,
      child: SizedBox(
        width: size,
        // height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///////////////   ADVICE WORDS    /////////////////
                  Text(
                    textAlign: TextAlign.center,
                    cardTxt,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: txtColor,
                        fontFamily: fontName,
                        fontSize: fontSize ?? 45),
                  ),
                  getSizedBox(false),
                  ///////////////   BY   /////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        txt,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: txtColor,
                              fontFamily: fontName,
                              fontSize: tilefontSize ?? 18,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GetLargeCardWidget extends StatelessWidget {
  GetLargeCardWidget({
    Key? key,
    required this.size,
    required this.txt,
    required this.cardColor,
    required this.cardTxt,
    required this.txtColor,
    required this.fontName,
    required this.cardIcon,
    required this.cardColumnWidget,
    this.fontSize,
    this.height,
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
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          radius: 3,
          colors: [
            cardColor,
            Colors.transparent,
            cardColor,
          ],
        )),
        width: size,
        height: height ?? 150,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: (size - 30) / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        cardIcon,
                        color: txtColor,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        txt,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: txtColor,
                              fontFamily: fontName,
                              fontSize: 24,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                VerticalDivider(
                  width: 1,
                  color: txtColor,
                  thickness: 1.0,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(child: cardColumnWidget),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GetMainCustomButton extends StatefulWidget {
  bool isPressed;
  GetMainCustomButton({
    Key? key,
    required this.isPressed,
  }) : super(key: key);

  @override
  State<GetMainCustomButton> createState() => _GetMainCustomButtonState();
}

class _GetMainCustomButtonState extends State<GetMainCustomButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.isPressed
          ? AppColors.blueColor.withOpacity(0.8) //STOP
          : AppColors.mainColor.withOpacity(0.8), // START
      // height: 150,
      minWidth: 150,
      elevation: 5,

      shape: const CircleBorder(),
      onPressed: () async {
        // show the dialog
        widget.isPressed
            ? await alertDialogWidget(
                    context,
                    "Are you sure to want stop smoking quitting".tr(),
                    "Read some pieces of advice and keep going with safe life "
                        .tr(),
                    2)
                .then((value) {
                if (value) {
                  value ? widget.isPressed = false : widget.isPressed = true;
                  context.read<ServicesProvider>().changeSmokingStatus(true);
                } else {}
              })
            : {
                widget.isPressed = !widget.isPressed,
                context.read<ServicesProvider>().changeSmokingStatus(false)
              };
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Wrap(
          children: [
            Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              widget.isPressed ? 'Stop'.tr() : 'Start Quit'.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
