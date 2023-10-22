

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/AuthController.dart';
import '../controllers/ChatContoller.dart';
import '../controllers/PostController.dart';
import '../controllers/UserController.dart';
import '../firebase_options.dart';


AuthController authController = AuthController.instance;
UserContoller userContoller = UserContoller.instance;
PostController postController = PostController.instance;
ChatController chatController = ChatController.instance;

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference userRef = db.collection('users');
CollectionReference postRef = db.collection('posts');
CollectionReference chatRef = db.collection('chats');


Reference storageReference = FirebaseStorage.instance.ref();

final box = GetStorage();

FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSign = GoogleSignIn();


mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex =  RegExp(pattern.toString());

    return regex.hasMatch(email);
  }

  bool phoneNumberValidator(String value) {
    Pattern pattern =
        r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern.toString());

    return regex.hasMatch(value);
  }

  bool numberValidator(String value) {
    Pattern pattern =
        r'(^[0-9]*$)';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(value);
  }
}

final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

processDialog(context){
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    pageBuilder: (context, anim1, anim2) {
      return Center(
        child: Container(
          width: 100,
          height: 100,
          child: StatefulBuilder(
            builder: (context, snapshot) {
              return Card(
                color: Theme.of(context).backgroundColor,
                child:   Center(
                    child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
              );
            },
          ),
        ),
      );
    },
  );
}

String getMessageFromErrorCode(errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
      break;
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
      break;
    default:
      return "Login failed. Please try again.";
      break;
  }
}

List<String> careerFields = [
  "Software Developer",
  "Accounting",
  "Computer Engineer",
  "Graphic Designer",
  "Healthcare",
  "Marketing",
  "Teacher/Education",
  "Legal",
  "Finance",
  "Aerospace Engineering",
  "Social Work",
  "Sales",
  "Medicine/Healthcare",
  "Human Resources",
  "Civil Engineering",
  "Architecture",
  "Environmental Science",
  "Journalism",
  "Psychology",
  "Data Science",
  "Manufacturing",
  "Automotive",
  "Retail",
  "Hospitality",
  "Agriculture",
  "Electrical Engineering",
  "Construction",
  "Art and Design",
  "Music",
  "Real Estate",
  "Management Consulting",
  "Public Relations",
  "Biotechnology",
  "Interior Design",
  "Public Administration",
  "Information Technology",
  "Pharmacy",
  "Culinary Arts",
  "Sports and Athletics",
  "Environmental Engineering"
];

