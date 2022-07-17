import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freesmoking/core/app_color.dart';

import '../home/widgets/home_screen_widgets.dart';
import '../login/custom_login_clipper.dart';
import 'register_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final heightOfAppBar = 56.0;

  final TextEditingController fNameController = TextEditingController();

  final TextEditingController lNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height - heightOfAppBar;
    log("==========reload=============");

    return Scaffold(
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
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: CustomLoginShapeClipper1(),
                  child: Container(
                    height: heightOfScreen,
                    decoration: BoxDecoration(
                        color: AppColors.blueColor.withOpacity(0.7)),
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: <Widget>[
                        getSizedBox(true),
                        buildIntroText(context),
                        BuildFormWidget(
                          controllers: [
                            fNameController,
                            lNameController,
                            emailController,
                            passwordController,
                            ageController
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
