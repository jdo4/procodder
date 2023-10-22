

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget signTextField(String text,bool isPassword,TextEditingController? controller,validation,onSaved){
  return Padding(
    padding:   EdgeInsets.all(2.h),
    child: TextFormField(
      validator: validation,
      onSaved: onSaved,
      controller:controller,
      style: const TextStyle(
          color: Colors.black
      ),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(
        ),
        filled: true,
        fillColor: const Color(0xffF1F4FF),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    ),
  );
}

Widget signInButton(context,String text,onPressed){
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5, //Defines Elevation

        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child:   Center(child: Text(text,style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 15.sp
      ),)));
}