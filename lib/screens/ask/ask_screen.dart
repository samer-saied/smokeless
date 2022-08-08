import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freesmoking/screens/home/home_screen.dart';
import 'package:freesmoking/screens/main_page_screen.dart';
import 'package:provider/provider.dart';

import '../../core/alert_dialog.dart';
import '../../core/app_color.dart';
import '../../provider/service_provider.dart';
import '../home/widgets/home_screen_widgets.dart';

class AskScreen extends StatefulWidget {
  final bool isSmoker;

  const AskScreen({Key? key, required this.isSmoker}) : super(key: key);

  @override
  State<AskScreen> createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  TextEditingController moneyController = TextEditingController();
  TextEditingController cigarettesController = TextEditingController();
  TextEditingController dailyCigarettesController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  bool isLoaded = false;
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          backgroundColor: AppColors.blackColor,
          body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.2,
                          image: AssetImage(
                            "assets/images/background.jpg",
                          ),
                          fit: BoxFit.cover)),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _keyForm,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getSizedBox(false),
                                Wrap(
                                  children: [
                                    Text(
                                      "One more step to help you ".tr(),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: AppColors.whiteColor,
                                          ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: AppColors.geryColor,
                                ),
                                Text(
                                  "How much in pounds sterling do you pay for a pack of cigarettes?"
                                      .tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                ),
                                getSizedBox(false),
                                getTextFormWidget(
                                  txtController: moneyController,
                                  txtHint: "Ex:".tr() + " 50 " + "EGP".tr(),
                                  context: context,
                                  txtType: TextInputType.number,
                                ),
                                getSizedBox(false),
                                Text(
                                  "How many cigarettes are in a pack?".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                ),
                                getSizedBox(false),
                                getTextFormWidget(
                                  txtController: cigarettesController,
                                  txtHint:
                                      "Ex:".tr() + " 20 " + "cigarettes".tr(),
                                  txtType: TextInputType.number,
                                  context: context,
                                ),
                                getSizedBox(false),
                                Text(
                                  "How many cigarettes do you smoke in a day?"
                                      .tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                ),
                                getSizedBox(false),
                                getTextFormWidget(
                                  txtController: dailyCigarettesController,
                                  txtHint:
                                      "Ex:".tr() + " 5 " + "cigarettes".tr(),
                                  txtType: TextInputType.number,
                                  context: context,
                                ),
                                getSizedBox(false),
                                widget.isSmoker
                                    ? Text(
                                        "How many years have you been smoking?"
                                            .tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppColors.whiteColor,
                                            ),
                                      )
                                    : const SizedBox(),
                                getSizedBox(false),
                                widget.isSmoker
                                    ? getTextFormWidget(
                                        txtController: yearsController,
                                        txtHint:
                                            "Ex:".tr() + " 3 " + "Years".tr(),
                                        txtType: TextInputType.number,
                                        context: context,
                                      )
                                    : const SizedBox(),
                                getSizedBox(true),
                                isLoaded
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.whiteColor,
                                      ))
                                    : ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.blueColor),
                                        ),
                                        onPressed: () {
                                          if (_keyForm.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoaded = !isLoaded;
                                            });
                                            try {
                                              Map<String, dynamic> updateData =
                                                  {
                                                "CPPrice": moneyController.text
                                                    .trim()
                                                    .toString(),
                                                "CPNumber": cigarettesController
                                                    .text
                                                    .trim()
                                                    .toString(),
                                                "CDaily":
                                                    dailyCigarettesController
                                                        .text
                                                        .trim()
                                                        .toString(),
                                                "NYS": widget.isSmoker
                                                    ? yearsController.text
                                                        .trim()
                                                        .toString()
                                                    : "0",
                                                "date": {
                                                  "years":
                                                      "${DateTime.now().year}", //- int.parse(yearsController.text.trim())
                                                  "months":
                                                      "${DateTime.now().month}",
                                                  "days":
                                                      "${DateTime.now().day}"
                                                }
                                              };
                                              context
                                                  .read<ServicesProvider>()
                                                  .updateUserData(updateData);
                                              context
                                                  .read<ServicesProvider>()
                                                  .getUserData(true);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainPageScreen()));
                                            } catch (error) {
                                              alertDialogWidget(
                                                  context,
                                                  "Error".tr(),
                                                  error.toString(),
                                                  1);
                                            }
                                          }
                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              "Submit".tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 26,
                                                    color: AppColors.whiteColor,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                getSizedBox(false),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.all<double>(0.1),
                                    side: MaterialStateProperty.all(BorderSide(
                                        color: AppColors.blueColor,
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainPageScreen()));
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "Skip".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 26,
                                              color: AppColors.whiteColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                  )))),
    );
  }
}

Widget getTextFormWidget(
    {required BuildContext context,
    required TextEditingController txtController,
    required TextInputType txtType,
    required String txtHint}) {
  return TextFormField(
    controller: txtController,
    enabled: true,
    textInputAction: TextInputAction.next,
    keyboardType: txtType,
    cursorHeight: 24,
    cursorColor: AppColors.whiteColor,
    style: TextStyle(
      color: AppColors.whiteColor,
    ),
    decoration: InputDecoration(
        fillColor: AppColors.darkgeryColor.withOpacity(0.8),
        labelStyle: TextStyle(color: AppColors.whiteColor),
        filled: true,
        isDense: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.mainColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.mainColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.blueColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.geryColor, width: 1),
        ),
        hintText: txtHint,
        hintStyle: TextStyle(
          color: AppColors.whiteColor.withOpacity(0.5),
        )),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Required'.tr();
      }
      return null;
    },
  );
}
