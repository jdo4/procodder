import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../config/config.dart';
import '../../main.dart';
import 'Components.dart';


class SignUpScreen extends StatefulWidget {
    const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with InputValidationMixin {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

    final formGlobalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return   Material(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: formGlobalKey,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png')
              )
            ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 15.h),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("Create Account",style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).primaryColor
                              ),),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: Text("Welcome back you've\n been missed!!",style: TextStyle(
                                  fontSize: 20.sp,
                                fontWeight: FontWeight.w600
                              ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      child: Padding(
                        padding:   EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Expanded(child: signTextField('First Name', false, _emailController,(text){
                                  if (text!.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Enter your first name';
                                  }
                                },(text){

                                } )),
                                Expanded(child: signTextField('Last Name', false, _emailController,(text){
                                  if (text!.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Enter your last name';
                                  }
                                },(text){

                                })),
                              ],
                            ),
                            signTextField('Email', false, _emailController,(text){
                              if (isEmailValid(text)) {
                                return null;
                              } else {
                                return 'please ! enter valid email address';
                              }
                            },(text){

                            }),
                            signTextField('Password', true, _passwordController,(text){
                              if (isPasswordValid(text)) {
                                return null;
                              } else {
                                return 'Password length must be at lease 6';
                              }
                            },(text){

                            }),
                            signTextField('Confirm Password', true, null,(text){
                              if (_passwordController.value.text == text) {
                                return null;
                              } else {
                                return 'Confirm password does not match with password ';
                              }
                            },(text){

                            }),

                            SizedBox(
                              height: 40.h,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    if (formGlobalKey.currentState!.validate()){
                                      formGlobalKey.currentState!.save();
                                      var result = await authController.register(_emailController.text.trim(),
                                          _passwordController.text.trim());
                                      if(result){
                                        Get.offAll(  MyHomePage());
                                      }
                                    }
                                    if(_passwordController.value.text.trim().toLowerCase() != _confirmPasswordController.value.text.trim().toLowerCase()){
                                      Fluttertoast.showToast(msg: "Password doesn't match with confirmed password");
                                      return;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5, //Defines Elevation

                                    shadowColor: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child:   Center(child: Text('Sign in',style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15.sp
                                  ),))),
                            ),

                            SizedBox(
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text("Already have an account ",style: TextStyle(

                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:   EdgeInsets.all(10.0.h),
                          child: Text("or continue with",style: TextStyle(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            fontSize: 15.sp,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      SizedBox(
                         width: 300.w,
                        height: 35.h,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffECECEC),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),

                          child : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Logo(Logos.google,size: 20,),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text('Google',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),),
                              ),
                            ],
                          ),
                        ),
                      )
                      ],
                    )
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
