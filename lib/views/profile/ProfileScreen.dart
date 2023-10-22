import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../config/config.dart';
import 'components.dart';

class ProfilePage extends StatelessWidget {

  ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>
      userContoller.isEmployeeAvailable.isTrue ?
         Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.fitWidth)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('https://wallpapers.com/images/high/profile-picture-background-10tprnkqwqif4lyv.webp')),
                            color: Theme.of(context).highlightColor,
                            borderRadius: const BorderRadius.all(Radius.circular(20))),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(userContoller.user.userName,
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(userContoller.user.userEmail,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Theme.of(context).highlightColor.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding:   const EdgeInsets.all(10.0),
                  children: [
                    profileListTile(context,"Password",Icons.password,true,(){}),
                    profileListTile(context,"Password",Icons.password,false,(){}),
                    profileListTile(context,"Password",Icons.password,false,(){}),
                    profileListTile(context,"Support",Icons.support,false,(){}),
                    profileListTile(context,"Sign out",HeroIcons.arrow_right_on_rectangle,false,(){
                      authController.signOut();
                    })
                  ],
                ),
              )
            ],
          ),
        ):
          Center(
            child: CircularProgressIndicator(),
          )
      ),
    );
  }
}
