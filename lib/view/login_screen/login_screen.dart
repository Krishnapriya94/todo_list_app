import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/utils/animation_constants/animation_constants.dart';
import 'package:todo_list_app/utils/color_constants/color_constants.dart';

import 'package:todo_list_app/view/task_screen/task_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final SharedPreferences prefs;

  @override
  void initState() {
    login();
    super.initState();
  }

  login() async {
    prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = await prefs.getBool("isLoggedIn") ?? false;
    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(),
          ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AnimationConstants.loginLottie),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.mainWhite,
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Username'),
                      validator: (value) {
                        if (usernameController.text != null) {
                          return null;
                        } else {
                          return "Enter your Name";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorConstants.mainWhite,
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Password'),
                      validator: (value) {
                        if (passwordController.text != null) {
                          return null;
                        } else {
                          return "Enter your password";
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorConstants.paleBlue)),
                onPressed: () async {
                  await prefs.setString("uname", usernameController.text);
                  await prefs.setString("password", passwordController.text);
                  await prefs.setBool('isLoggedIn', true);
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(),
                      ),
                    );
                  } else {
                    print("Validation is not successful");
                  }
                },
                child: Text(
                  'Login',
                  style:
                      TextStyle(fontSize: 18, color: ColorConstants.mainWhite),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(
                        color: ColorConstants.mainWhite, fontSize: 16),
                  ),
                  InkWell(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: ColorConstants.paleBlue, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
