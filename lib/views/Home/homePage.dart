import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:procodder/config/config.dart';

import 'Components.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title:  const Text("Peer Finder"),
        elevation: 0.0,
        actions: [IconButton(onPressed: () {
          authController.signOut();
        }, icon: const Icon(HeroIcons.bell))],
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            // this is my own class which extendsCustomClipper
            child: Container(
              height: 250,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                //shrinkWrap: true,
                children: [

                  //spacer
                  SizedBox(
                    height: 25.h,
                  ),

                  //Inventory
                  Container(
                    height: 170.h,
                    width: 330.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor.withOpacity(.8),

                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        children: [
                          Expanded(flex: 2,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text("Inventory Summery",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold

                                    ),),
                                  ))),
                          Expanded(flex: 8,
                              child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).highlightColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(flex: 4,child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(FontAwesome.cubes,size: 25.h,color: Colors.green,))),
                                            Expanded(flex: 2,child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Quantity in hand",style: TextStyle(
                                                color: Theme.of(context).unselectedWidgetColor,
                                                fontWeight: FontWeight.bold
                                              ),),
                                            )),
                                            Expanded(flex: 4,child:  Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("202",
                                                style: TextStyle(
                                                    fontSize: 25.sp,
                                                    fontWeight: FontWeight.bold

                                                ),),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).highlightColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Expanded(flex: 4,child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(FontAwesome.fly,size: 25.h,color: Colors.orange,))),
                                            Expanded(flex: 2,child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Will be Received",style: TextStyle(
                                                color: Theme.of(context).unselectedWidgetColor,
                                                fontWeight: FontWeight.bold
                                              ),),
                                            )),
                                            Expanded(flex: 4,child:  Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("202",
                                                style: TextStyle(
                                                    fontSize: 25.sp,
                                                    fontWeight: FontWeight.bold

                                                ),),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),

                  //spacer
                  SizedBox(
                    height: 20.h,
                  ),

                  //NO of Users
                  Container(
                    height: 170.h,
                    width: 330.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,

                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        children: [
                          Expanded(flex: 2,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text("No. Of Users",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold

                                      ),),
                                  ))),
                          Expanded(flex: 8,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //total no of users
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).indicatorColor.withOpacity(.2),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(flex: 4,child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Icon(FontAwesome.users,size: 25.h,color: Colors.green,))),
                                                Expanded(flex: 2,child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Total Employee",style: TextStyle(
                                                      color: Theme.of(context).unselectedWidgetColor,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                )),
                                                Expanded(flex: 4,child:  Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("202",
                                                    style: TextStyle(
                                                        fontSize: 25.sp,
                                                        fontWeight: FontWeight.bold

                                                    ),),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(

                                              color: Theme.of(context).indicatorColor.withOpacity(.2),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(15),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [
                                                Expanded(flex: 4,child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Icon(FontAwesome.people_group,size: 25.h,color: Colors.blue,))),
                                                Expanded(flex: 2,child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Total Suppliers",style: TextStyle(
                                                      color: Theme.of(context).unselectedWidgetColor,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                )),
                                                Expanded(flex: 4,child:  Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("202",
                                                    style: TextStyle(
                                                        fontSize: 25.sp,
                                                        fontWeight: FontWeight.bold

                                                    ),),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),

                  //History
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,

                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        )),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
