class Post {
  String postID;
  String postTitle;
  String postDescription;
  List<String> postImage;
  List<String> courseCategory;
  List<String> subCategory;
  List<String> skills;
  String userID;
  String datePosted;// Foreign Key

  Post({
    required this.postID,
    required this.postTitle,
    required this.postDescription,
    required this.postImage,
    required this.courseCategory,
    required this.subCategory,
    required this.skills,
    required this.userID,
    required this.datePosted,
  });

  // Convert the Post object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'postID': postID,
      'postTitle': postTitle,
      'postDescription': postDescription,
      'postImage': postImage,
      'courseCategory': courseCategory,
      'subCategory': subCategory,
      'skills': skills,
      'userID': userID,
      'datePosted':datePosted
    };
  }

  // Create a Post object from a JSON map.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postID: json['postID'] as String,
      postTitle: json['postTitle'] as String,
      postDescription: json['postDescription'] as String,
      postImage: (json['postImage'] as List).cast<String>(),
      courseCategory: (json['courseCategory'] as List).cast<String>(),
      subCategory: (json['subCategory'] as List).cast<String>(),
      skills: (json['skills'] as List).cast<String>(),
      userID: json['userID'] as String,
      datePosted: json['datePosted'] as String,
    );
  }
}