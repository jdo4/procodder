import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:procodder/config/config.dart';
import 'package:procodder/models/User.model.dart';

import '../../models/Post.model.dart';
import '../Chat/ChatScreen.dart';

class postScreen extends StatefulWidget {
  const postScreen({Key? key}) : super(key: key);

  @override
  State<postScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<postScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text("SolveMate"),
      ),
      body: Obx(() => postController.hasData.isTrue
          ? postController.posts.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: postController.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post data = postController.posts.elementAt(index);
                      User u = userContoller.getEmployeeDetail(data.userID);
                      DateTime dt = DateTime.parse(data.datePosted);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: InkWell(
                          onTap: (){
                            String currentUserId = box.read("userId");
                            String uid = "${u.userID}__$currentUserId";
                            chatController.subscribeToFirestoreStream(uid);
                            Get.to(()=> ChatPage(uid : uid, u: u,));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .unselectedWidgetColor
                                          .withOpacity(.5),
                                      child: Center(
                                        child: Text(u.userName[0],style: TextStyle(
                                          color: Theme.of(context).primaryColor
                                        ),),
                                      ),
                                    ),
                                    title: Text(u.userName),
                                    subtitle: Text("${dt.month}-${dt.day}-${dt.year}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data.postDescription,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).primaryColor,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  data.postImage.first),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(onPressed: (){}, icon:const Icon(FontAwesome.thumbs_up)),
                                        IconButton(onPressed: (){}, icon:const Icon(FontAwesome.comments)),
                                        IconButton(onPressed: (){}, icon:const Icon(FontAwesome.share)),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  ))
              : const Center(child: CircularProgressIndicator())
          : const Center(child: CircularProgressIndicator())),
    );
  }
}
