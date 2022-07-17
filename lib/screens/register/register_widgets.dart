import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freesmoking/screens/ask/ask_screen.dart';

import '../../core/alert_dialog.dart';
import '../../core/app_color.dart';
import '../../services/firebase_storage.dart';
import '../home/widgets/home_screen_widgets.dart';
import '../login/custom_text_form_field.dart';
import '../login/login_screen.dart';
import '../widgets/custom_button_widget.dart';

enum SmokingState { yes, no }

SmokingState? _smokingState = SmokingState.yes;

class BuildFormWidget extends StatefulWidget {
  final List<TextEditingController> controllers;

  const BuildFormWidget({
    Key? key,
    required this.controllers,
  }) : super(key: key);

  @override
  State<BuildFormWidget> createState() => _BuildFormWidgetState();
}

class _BuildFormWidgetState extends State<BuildFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextFormField(
            hasPrefixIcon: true,
            textInputType: TextInputType.emailAddress,
            labelStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            hintText: "Frist name".tr(),
            txtController: widget.controllers[0],
            textStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            hintTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            // textStyle: Styles.customTextStyle(color: AppColors.whiteColor),
            prefixIcon: Icon(
              FontAwesomeIcons.solidUser,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          getSizedBox(false),
          CustomTextFormField(
            hasPrefixIcon: true,
            txtController: widget.controllers[1],

            textInputType: TextInputType.text,
            textStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            titleStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            // textStyle: Styles.customTextStyle(color: AppColors.white),
            hintText: "Last name".tr(),
            hintTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            obscured: false,
            prefixIcon: Icon(
              FontAwesomeIcons.users,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          getSizedBox(false),
          CustomTextFormField(
            hasPrefixIcon: true,
            textInputType: TextInputType.emailAddress,
            txtController: widget.controllers[2],

            textStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            titleStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            // textStyle: Styles.customTextStyle(color: AppColors.white),
            hintText: "Email".tr(),
            hintTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            obscured: false,
            prefixIcon: Icon(
              FontAwesomeIcons.solidEnvelope,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          getSizedBox(false),
          CustomTextFormField(
            hasPrefixIcon: true,
            textInputType: TextInputType.text,
            txtController: widget.controllers[3],

            textStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            titleStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            // textStyle: Styles.customTextStyle(color: AppColors.white),
            hintText: "Password".tr(),
            hintTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            obscured: true,
            prefixIcon: Icon(
              FontAwesomeIcons.key,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          getSizedBox(false),
          CustomTextFormField(
            hasPrefixIcon: true,
            textInputType: TextInputType.number,
            txtController: widget.controllers[4],

            textStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            titleStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            // textStyle: Styles.customTextStyle(color: AppColors.white),
            hintText: "Age".tr(),
            hintTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            obscured: false,
            prefixIcon: Icon(
              FontAwesomeIcons.calculator,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          getSizedBox(false),
          getSizedBox(false),
          const RadioButtonWidget(),
          getSizedBox(false),
          isLoad
              ? CircularProgressIndicator(
                  color: AppColors.whiteColor,
                )
              : CustomButton(
                  title: "Create User".tr(),
                  borderRadius: 8,
                  borderSide:
                      BorderSide(color: AppColors.whiteColor.withOpacity(0.5)),
                  color: AppColors.blueColor,
                  elevation: 1,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.create,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  hasIcon: false,
                  height: 50,
                  textStyle: textTheme.button!.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoad = !isLoad;
                      });
                      try {
                        DateTime now = DateTime.now();
                        await FirebaseStorage()
                            .signUp(
                                email: widget.controllers[2].text,
                                password: widget.controllers[3].text)
                            .then((value) {
                          if (value != null) {
                            FirebaseStorage().saveUserData({
                              "fName":
                                  widget.controllers[0].text.trim().toString(),
                              "lName":
                                  widget.controllers[1].text.trim().toString(),
                              "email":
                                  widget.controllers[2].text.trim().toString(),
                              "age":
                                  widget.controllers[4].text.trim().toString(),
                              "smoking": _smokingState == SmokingState.yes
                                  ? true
                                  : false,
                              "id": value.user!.uid,
                              "CPPrice": "0",
                              "CPNumber": "0",
                              "CDaily": "0",
                              "NYS": "0",
                              "date": {
                                "years": "${now.year}",
                                "months": "${now.month}",
                                "days": "${now.day}",
                              }
                            }).then((value) {
                              /////////
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: ((context) => AskScreen(
                                            isSmoker: (_smokingState ==
                                                    SmokingState.yes)
                                                ? true
                                                : false,
                                          ))));
                            });
                          }
                        });
                      } catch (e) {
                        setState(() {
                          isLoad = !isLoad;
                        });
                        alertDialogWidget(
                            context, "Error".tr(), e.toString(), 1);
                      }
                    }
                  },
                ),
          getSizedBox(false),
          InkWell(
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()))
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "I already have an account.".tr(),
                textAlign: TextAlign.center,
                style: textTheme.subtitle1!.copyWith(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          getSizedBox(false),
        ],
      ),
    );
  }
}
////////////////////////////  BUTTON REGISTER SCREEN   ////////////////////////////

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({Key? key}) : super(key: key);

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: [
          Text(
            "Smoking state".tr(),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: AppColors.whiteColor,
                ),
          ),
        ]),
        RadioListTile<SmokingState>(
          activeColor: AppColors.whiteColor,
          title: Text(
            "Yes,i am still smoking".tr(),
            style: TextStyle(color: AppColors.whiteColor),
          ),
          value: SmokingState.yes,
          groupValue: _smokingState,
          onChanged: (SmokingState? value) {
            setState(() {
              _smokingState = value;
            });
          },
        ),
        RadioListTile<SmokingState>(
          activeColor: AppColors.whiteColor,
          title: Text(
            'No,i am not Smoker'.tr(),
            style: TextStyle(color: AppColors.whiteColor),
          ),
          value: SmokingState.no,
          groupValue: _smokingState,
          onChanged: (SmokingState? value) {
            setState(() {
              _smokingState = value;
            });
          },
        ),
      ],
    );
  }
}

////////////////////////////  BACKGROUND INTRO REGISTER SCREEN   ////////////////////////////
Widget buildIntroText(
  BuildContext context,
) {
  var textTheme = Theme.of(context).textTheme;

  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Icon(
              FontAwesomeIcons.pencil,
              color: AppColors.whiteColor,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Create".tr(),
                style: textTheme.headline4!.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        getSizedBox(false),
      ],
    ),
  );
}
