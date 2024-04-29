import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  final dynamic college;
  final dynamic branch;
  final dynamic semester;
  final dynamic id;

  UserData({
    this.name,
    this.email,
    this.phone,
    this.college,
    this.branch,
    this.semester,
    this.id,
  });

  // user model from json
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: FirebaseAuth.instance.currentUser!.displayName,
      email: FirebaseAuth.instance.currentUser!.email,
      phone: json['phone'],
      college: json['college'],
      branch: json['branch'],
      semester: json['semester'],
      id: json['uid'],
    );
  }
}
