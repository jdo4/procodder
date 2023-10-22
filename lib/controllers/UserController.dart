

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../config/config.dart';
import 'package:procodder/models/User.model.dart' as u;

import '../models/User.model.dart';

class UserContoller extends GetxController {
  static UserContoller instance = Get.find();
  Rx<bool> isEmployeeAvailable = false.obs;
  RxBool hasData = false.obs;
  RxBool hasEmployeeDetails = false.obs;
  late User user ;
  List<u.User> users = [];
  late StreamSubscription<QuerySnapshot> _subscription;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEmployeeData();
    _subscribeToFirestoreStream();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  void _subscribeToFirestoreStream() {
    print(DateTime.now());
    hasData.value = false;
    _subscription = userRef.snapshots().listen((QuerySnapshot snapshot) {
      hasData.value = false;
      users = [];
      if (snapshot.docs.isEmpty) {
        hasData.value = true;
        return;
      }
      for (var element in snapshot.docs) {
        users.add(User.fromJson(element.data() as Map<String, dynamic>));
      }
      print(users);
      hasEmployeeDetails.value = false;
      hasData.value = true;
    });
  }


  getEmployeeDetail(String id){
    if(id.toString() != ''){
      hasEmployeeDetails.value = true;
      print(users.length);
       return  users.where((element) => element.userID == id).first;
    }
  }


  getEmployeeData() async {
      try {
        String userid  = box.read('userId');
        print(userid);
        // Reference to the document
        DocumentReference documentRef = userRef.doc(userid);

        // Fetch the document
        DocumentSnapshot documentSnapshot = await documentRef.get();

        if (documentSnapshot.exists) {
          // Document exists, you can access its data
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

          // Access specific fields

          user = u.User.fromJson(data);
          print(user.userEmail);
          isEmployeeAvailable.value = true;
        } else {
          // Document doesn't exist
          print('Document does not exist');
        }
      } catch (e) {
        print('Error retrieving document: $e');
      }
    }
  }

