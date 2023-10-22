

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Views/signin_signup/login_screen.dart';
import '../config/config.dart';
import 'package:procodder/models/User.model.dart' as u;
import 'UserController.dart' ;


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool isLoggedIn = false.obs;
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;




  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);


    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);


    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);


  }



  _setInitialScreen(User? user) {
    print('setting screen');
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      isLoggedIn.value = false;

    } else {

      Get.put(UserContoller());
      // if the user exists and logged in the the user is navigated to the Home Screen
      isLoggedIn.value = true;

    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      // Get.offAll(() => const Register());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      //  Get.offAll(() => MyHomePage(title: ""));
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential result =  await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
        await createUserProfile(result.user!);
        // Get.offAll(() => const MyHomePage(title: 'InventoWise'));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  Future<bool> register(String email, password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await createUserProfile(credential.user!);
      return true;
    } catch (firebaseAuthException) {
      String error = firebaseAuthException.toString().split("]").last;
      Get.snackbar(
        "Error",
        error,
        snackPosition: SnackPosition.BOTTOM,
      );

      print(firebaseAuthException);
      return false;

    }
  }

  createUserProfile(User user) async {

    await box.write('userId', user.uid);

    u.User users = u.User(
        userID: user.uid,
        userName: user.displayName.toString(), userEmail: user.email.toString(), userLocation: 'waterloo', userSchoolCollege: 'Conestoga College', userCourse: 'Mobile Solution Development', userSkills: ['Android','Ios','Web development','software development','computer science']);

    DocumentReference ref = userRef.doc(user.uid);
    await ref.set(users.toJson(),SetOptions(merge: true));
    _setInitialScreen(user);
  }

  Future<bool> login(String email, password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }  on FirebaseAuthException catch (e) {
      String errorMessege =  getMessageFromErrorCode(e.code);
      Fluttertoast.showToast(msg:errorMessege,backgroundColor: Colors.red);
      return false;
    }
  }
  void signOut() async {
    await auth.signOut();
    Get.off(LoginScreen());
  }
}