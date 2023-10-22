class User {
  String userID;
  String userName;
  String userEmail;
  String userLocation;
  String userSchoolCollege;
  String userCourse;
  List<dynamic> userSkills;

  User({
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.userLocation,
    required this.userSchoolCollege,
    required this.userCourse,
    required this.userSkills,
  });

  // Convert the User object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'userName': userName,
      'userEmail': userEmail,
      'userLocation': userLocation,
      'userSchoolCollege': userSchoolCollege,
      'userCourse': userCourse,
      'userSkills': userSkills,
    };
  }

  // Create a User object from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      userLocation: json['userLocation'] as String,
      userSchoolCollege: json['userSchoolCollege'] as String,
      userCourse: json['userCourse'] as String,
      userSkills: json['userSkills'],
    );
  }
}