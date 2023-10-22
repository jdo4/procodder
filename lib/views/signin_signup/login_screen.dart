import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:procodder/views/signin_signup/signup_screen.dart';
import '../../config/config.dart';
import '../../main.dart';
import 'Components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController(text: 'darshanjasoliya903@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'darshan903');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/background.png'))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 15.h),
                    height: 131.h,
                    width: 228.w,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: Text(
                              "Login here",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: Text(
                              "Welcome back you've\n been missed!!",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: SizedBox(
                  width: 300.w,
                  height: 369.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      signTextField('Email', false, _emailController,(text){},(text){}),
                      signTextField('Password', true, _passwordController,(text){},(text){}),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){},
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                        child: signInButton(
                          context,
                          'Sign in',
                          () async {
                            print('Log in start');

                            var result = await authController.login(_emailController.text.trim(),
                                _passwordController.text.trim());

                            result ? Get.off(const MyHomePage()): null;
                          },
                        ),
                      ),
                      SizedBox(
                        child: TextButton(
                          onPressed: (){
                            print("btn tapped");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>   SignUpScreen()));
                          },
                          child: Text(
                            "Create new account",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Text(
                          "or continue with",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 300.w,
                        height: 35.h,
                        child: ElevatedButton(
                          onPressed: () {
                            authController.signInWithGoogle();

                            print('Button Pressed');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffECECEC),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Logo(
                                Logos.google,
                                size: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Google',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
