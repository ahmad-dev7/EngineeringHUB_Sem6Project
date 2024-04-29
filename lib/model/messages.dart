import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final dynamic message;
  final dynamic uid;
  final dynamic name;
  final dynamic college;
  final dynamic branch;
  final dynamic semester;
  final dynamic phone;
  final Timestamp? timestamp;

  Messages({
    this.message,
    this.uid,
    this.name,
    this.college,
    this.branch,
    this.semester,
    this.phone,
    this.timestamp,
  });
  // 'message': message,
  // 'uid': auth.currentUser!.uid,
  // 'name': auth.currentUser!.displayName,
  // 'college': myCtrl.selectedCollege.value,
  // 'branch': myCtrl.selectedBranch.value,
  // 'semester': myCtrl.selectedSemester.value,
  // 'phone': myCtrl.userData.value.phone,
  // 'timestamp': Timestamp.now(),
  factory Messages.fromSnapshot(Map<String, dynamic> snapShot) {
    return Messages(
      message: snapShot['message'],
      uid: snapShot['uid'],
      name: snapShot['name'],
      college: snapShot['college'],
      branch: snapShot['branch'],
      semester: snapShot['semester'],
      phone: snapShot['phone'],
      timestamp: snapShot['timestamp'],
    );
  }
}
