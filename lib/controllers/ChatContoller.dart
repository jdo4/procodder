import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../config/config.dart';
import '../models/Chat.model.dart';
import '../models/Post.model.dart';


class ChatController extends GetxController {
  static ChatController instance = Get.find();

  RxBool hasData = false.obs;
  List<ChatMessage> chatmsg = [];
  late StreamSubscription<QuerySnapshot> _subscription;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _subscription.cancel();
  }

  void subscribeToFirestoreStream(String id) {
    print("Getting chat");
    hasData.value = false;
    print(id);
    _subscription = chatRef.doc(id).collection("messages").snapshots().listen((QuerySnapshot snapshot) {
      hasData.value = false;
      chatmsg = [];
      if (snapshot.docs.isEmpty) {
        print("empty");
        hasData.value = true;
        return;
      }
      for (var element in snapshot.docs) {
        chatmsg.add(ChatMessage.fromJson(element.data() as Map<String, dynamic>));
      }
      print(chatmsg.first.message);
      hasData.value = true;
    });
  }
  newMassage(String id,ChatMessage ct) async {
   await chatRef.doc(id).collection("messages").doc().set(ct.toJson());
  }

  addNewCategory(Post category) async {
    DocumentReference documentReference = chatRef.doc();

    // Get the auto-generated document ID
    String autoGeneratedID = documentReference.id;

    category.postID = autoGeneratedID;

    await documentReference.set(category.toJson());
  }


  Future<List<String>> uploadImages(List<File> images) async {
    if (images.isEmpty) return [];

    List<String> downloadUrls = [];

    await Future.forEach(images, (image) async {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('posts')
          .child(image.path.split("/").last);
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final url = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(url);
    });
    return downloadUrls;
  }

}
