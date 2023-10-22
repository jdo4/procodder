import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:procodder/models/Post.model.dart';

import '../../config/config.dart';


class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key }) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<CreatePostScreen>
    with InputValidationMixin {
  final formGlobalKey = GlobalKey<FormState>();


  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String> listOFSelectedItem = [];
  String selectedText= "";

  List<String> listOFSelectedSubCategory = [];
  String selectedSubCat= "";

  Post post = Post(postID: '', postTitle: '', postDescription: '', postImage: [], courseCategory: [], subCategory: [], skills: [], userID: '', datePosted: '');

  void selectImages() async {
    final List<XFile> selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:${imageFileList!.length}");
    setState((){});
  }

  List<String> subCatFields = ["Learning", "Projects", "Problem/Solution", "Study Tips", "Others"];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
        "New Post",
          style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () async {

                 if (formGlobalKey.currentState!.validate()) {
                   formGlobalKey.currentState!.save();
                   if(listOFSelectedItem.isEmpty){
                     Get.snackbar(
                       "",
                      "Please select categories",
                       snackPosition: SnackPosition.BOTTOM,
                     );
                   }else if(listOFSelectedSubCategory.isEmpty){
                     Get.snackbar(
                       "",
                       "Please select categories",
                       snackPosition: SnackPosition.BOTTOM,
                     );
                   }else{
                     String userid  = box.read('userId');
                     post.datePosted = DateTime.now().toString();
                     post.userID = userid;
                     post.courseCategory = listOFSelectedItem;
                     post.subCategory = listOFSelectedSubCategory;
                     List<File> _images = [];
                     processDialog(context);
                     imageFileList!.forEach((element) {
                       _images.add(File(element.path));
                     });

                     List<String> lis = await postController.uploadImages(_images);
                     if(lis.isNotEmpty){
                       post.postImage = lis;
                       await postController.addNewCategory(post);

                       Navigator.pop(context);

                       post = Post(postID: '', postTitle: '', postDescription: '', postImage: [], courseCategory: [], subCategory: [], skills: [], userID: '', datePosted: '');
                       imageFileList!.clear();
                       listOFSelectedSubCategory.clear();
                       listOFSelectedItem.clear();

                     }else{

                     }
                   }
                 }
              },
              child: Text("Add",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).highlightColor,
                    fontSize: 15.sp),
              ))
        ],
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formGlobalKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor
                  ),
                  child: imageFileList!.isEmpty ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        selectImages();
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).highlightColor,
                        ),
                        child: const Center
                          (child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesome.square_plus),
                            Text("Select images"),
                          ],
                        )),
                      ),
                    ),
                  ) : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: imageFileList?.length,
                          itemBuilder:(context,int index){
                            XFile? data = imageFileList?.elementAt(index);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor,
                                  image: DecorationImage(
                                    image: FileImage(File(data!.path)),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text('Title'),
                const SizedBox(height: 10),
                TextFormField(
                  onSaved: (value) {
                        post.postTitle = value!;
                  },
                //initialValue: widget.edit ? employeeContoller.employeeDetail.value.firstName : null,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Title',
                    hintStyle: const TextStyle(),
                    filled: true,
                    fillColor: Theme.of(context).highlightColor,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (name) {
                    if (name!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid Product name';
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Text('Description'),
                const SizedBox(height: 10),
                TextFormField(
                 // initialValue: widget.edit ? employeeContoller.employeeDetail.value.lastName : null,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Description',
                    hintStyle: const TextStyle(),
                    filled: true,
                    fillColor: Theme.of(context).highlightColor,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (password) {
                    if (password!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter product description Name';
                    }
                  },
                  onSaved: (value) {
                    post.postDescription = value!;
                  },
                ),
                const SizedBox(height: 10),
                const Text('Category'),
                const SizedBox(height: 10),
                Card(
                  elevation: 0.0 ,
                  color: Theme.of(context).highlightColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.location_on_rounded),
                        ),
                        Text(
                          listOFSelectedItem.isEmpty
                              ? "Select"
                              : listOFSelectedItem[0],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: careerFields.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: ViewItem(
                                location:careerFields[index],
                                selected: (val) {
                                  selectedText = val;
                                  if (listOFSelectedItem.contains(val)) {

                                    listOFSelectedItem.remove(val);
                                  } else {
                                    listOFSelectedItem.add(val);
                                  }
                                  // widget.selectedList(listOFSelectedItem);
                                  setState(() {});
                                },
                                itemSelected: listOFSelectedItem.contains(careerFields[index])),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Text('Sub-category'),
                const SizedBox(height: 10),
                Card(
                  elevation: 0.0 ,
                  color: Theme.of(context).highlightColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.location_on_rounded),
                        ),
                        Text(
                          listOFSelectedSubCategory.isEmpty
                              ? "Select"
                              : listOFSelectedSubCategory[0],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: subCatFields.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: ViewItem(
                                location:subCatFields[index],
                                selected: (val) {
                                  selectedSubCat = val;
                                  if (listOFSelectedSubCategory.contains(val)) {

                                    listOFSelectedSubCategory.remove(val);
                                  } else {
                                    listOFSelectedSubCategory.add(val);
                                  }
                                  // widget.selectedList(listOFSelectedItem);
                                  setState(() {});
                                },
                                itemSelected: listOFSelectedSubCategory.contains(subCatFields[index])),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ViewItem extends StatelessWidget {
  String location;
  bool itemSelected;
  Function(String) selected;

  ViewItem(
      {super.key, required this.location, required this.itemSelected, required this.selected});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
      EdgeInsets.only(left: size.width * .032, right: size.width * .098),
      child: Row(
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: itemSelected,
              onChanged: (val) {
                selected(location);
              },

            ),
          ),
          SizedBox(
            width: size.width * .025,
          ),
          Text(
            location,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
