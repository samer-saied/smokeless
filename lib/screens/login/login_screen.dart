import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freesmoking/core/app_color.dart';
import 'package:freesmoking/models/firebase_exception.dart';
import 'package:freesmoking/screens/forget/forget_screen.dart';
import 'package:freesmoking/screens/register/register_screen.dart';
import 'package:freesmoking/services/firebase_storage.dart';

import '../../core/alert_dialog.dart';
import '../home/widgets/home_screen_widgets.dart';
import '../main_page_screen.dart';
import '../widgets/custom_button_widget.dart';
import 'custom_login_clipper.dart';
import 'custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseStorage().authState,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(snapshot.error.toString())));
          } else if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainPageScreen()));
            });
          } else {
            return LoginMainWidget(
              emailController: emailController,
              passwordController: passwordController,
            );
          }
          return LoginMainWidget(
            emailController: emailController,
            passwordController: passwordController,
          );
        });
  }
}

class LoginMainWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginMainWidget(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const heightOfAppBar = 56.0;

    var heightOfScreen = MediaQuery.of(context).size.height - heightOfAppBar;

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
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        getSizedBox(true),
                        buildIntroText(context),
                        SizedBox(height: heightOfScreen * 0.05),
                        BuildLoginFormWidget(
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        getSizedBox(false),
                        getSizedBox(false),
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

class BuildLoginFormWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const BuildLoginFormWidget(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<BuildLoginFormWidget> createState() => _BuildLoginFormWidgetState();
}

class _BuildLoginFormWidgetState extends State<BuildLoginFormWidget> {
  final formKey = GlobalKey<FormState>();
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Form(
        key: formKey,
        child: Column(children: <Widget>[
          CustomTextFormField(
            txtController: widget.emailController,
            hasPrefixIcon: true,
            textInputType: TextInputType.emailAddress,
            labelStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            hintText: "Email address".tr(),
            textStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            hintTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            prefixIcon: Icon(
              Icons.mail,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          getSizedBox(false),
          CustomTextFormField(
            txtController: widget.passwordController,
            hasPrefixIcon: true,
            textInputType: TextInputType.text,
            textStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            titleStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            hintText: "Password".tr(),
            hintTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            obscured: true,
            prefixIcon: Icon(
              Icons.key,
              color: AppColors.whiteColor,
              size: 20,
            ),
          ),
          getSizedBox(true),
          isLoaded
              ? CircularProgressIndicator(
                  color: AppColors.whiteColor,
                )
              : CustomButton(
                  title: "Sign me in".tr(),
                  borderRadius: 8,
                  borderSide:
                      BorderSide(color: AppColors.whiteColor.withOpacity(0.4)),
                  color: AppColors.blueColor,
                  elevation: 5,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.login,
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
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoaded = !isLoaded;
                      });
                      try {
                        await FirebaseStorage()
                            .signIn(
                                email: widget.emailController.text
                                    .trim()
                                    .toString(),
                                password: widget.passwordController.text
                                    .trim()
                                    .toString())
                            .then((value) {
                          setState(() {
                            isLoaded = false;
                          });
                        });
                      } on FirebaseServerException catch (e) {
                        setState(() {
                          isLoaded = false;
                        });
                        alertDialogWidget(
                            context, "Error".tr(), e.msg.toString(), 1);
                      }
                    }
                  }),
          getSizedBox(false),
          InkWell(
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()))
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Don't have an account".tr() + " , " + "register now".tr(),
                textAlign: TextAlign.center,
                style: textTheme.subtitle1!.copyWith(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForgetScreen()))
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Forget password".tr(),
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
        ]));
  }
}

Widget buildIntroText(BuildContext context) {
  var textTheme = Theme.of(context).textTheme;
  var heightOfScreen = MediaQuery.of(context).size.height - 55;

  return ListBody(
    children: <Widget>[
      Text(
        "WELCOME".tr(),
        style: textTheme.headline3!.copyWith(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w900,
        ),
      ),
      Text(
        "BACK !".tr(),
        style: textTheme.headline3!.copyWith(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w900,
        ),
      ),
      getSizedBox(false),
      Text(
        "Good to see you again".tr(),
        style: textTheme.bodyMedium!.copyWith(
          color: AppColors.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: heightOfScreen * 0.15),
      Text(
        "SIGN IN".tr(),
        style: textTheme.headline4!.copyWith(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    ],
  );
}
