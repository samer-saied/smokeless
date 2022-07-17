import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freesmoking/screens/home/home_screen.dart';
import 'package:freesmoking/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

import '../../core/app_color.dart';
import '../../provider/service_provider.dart';
import '../ask/ask_screen.dart';
import '../home/widgets/home_screen_widgets.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController emailController = TextEditingController();

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
                                      "Please enter your recovery email".tr(),
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
                                getTextFormWidget(
                                  txtController: emailController,
                                  txtHint: "E-mail".tr(),
                                  context: context,
                                  txtType: TextInputType.emailAddress,
                                ),
                                getSizedBox(false),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.blueColor),
                                  ),
                                  onPressed: () {
                                    if (_keyForm.currentState!.validate()) {
                                      try {
                                        ServicesProvider servicesProvider =
                                            context.read<ServicesProvider>();
                                        servicesProvider.forgetPassword(
                                            servicesProvider
                                                .currentUserData!.email
                                                .toString());
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      } catch (error) {
                                        log(error.toString());
                                      }
                                    }
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "Send now".tr(),
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
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ));
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
