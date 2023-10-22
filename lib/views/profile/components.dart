

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

Widget profileListTile(BuildContext context,String title,IconData icon,bool showErrow,var onTap ){
  return  Padding(
    padding:
    const EdgeInsets.all(10.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).unselectedWidgetColor.withOpacity(.2),

          ),
          child: Row(
            children: <Widget>[
              Container(
                color: Theme.of(context).unselectedWidgetColor.withOpacity(.2),
                width: 70,
                height: 70,
                child:   Icon(icon, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(width: 10),
                Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp
                    ),),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: showErrow?  const Icon(Icons.arrow_forward_ios, color: Colors.grey):null,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}