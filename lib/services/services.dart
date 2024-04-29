import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/model/youtube_video_data.dart';

class BackendServices {
  var myCtrl = Get.put(MyController());
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  //* User's collection
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  //* Message's collection
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  //* note's collection
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
  //* YouTube video/playlist collection
  final CollectionReference youtubeUrls =
      FirebaseFirestore.instance.collection('youtubeUrls');
  String apiKey = 'AIzaSyDfCb-cAuY_tWoliNt2BeOwNajpznrtqLE';
  String baseUrl = 'https://www.googleapis.com/youtube/v3';

  //* Create user
  Future createUser(
      {required UserData userData, required String password}) async {
    try {
      var response = await auth.createUserWithEmailAndPassword(
        email: userData.email!,
        password: password,
      );

      if (response.user != null) {
        await response.user!.updateDisplayName(userData.name);
        users.add({
          'college': userData.college,
          'branch': userData.branch,
          'semester': userData.semester,
          'phone': userData.phone,
          'uid': response.user!.uid,
        });
        myCtrl.userData.value = UserData(
          name: userData.name,
          id: response.user!.uid,
          email: userData.email,
          college: userData.college,
          branch: userData.branch,
          semester: userData.semester,
          phone: userData.phone,
        );
        myCtrl.selectedCollege.value = userData.college;
        myCtrl.selectedBranch.value = userData.branch;
        myCtrl.selectedSemester.value = userData.semester;
        return true;
      }

      return false;

      //
    } catch (e) {
      return false;
    }
  }

  //* Login user
  Future loginUser({required String email, required String password}) async {
    try {
      var response = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        await getUserData();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //* Get User Data
  Future getUserData() async {
    var userData =
        await users.where('uid', isEqualTo: auth.currentUser!.uid).get();
    myCtrl.userData.value = UserData.fromJson(
      userData.docs[0].data() as Map<String, dynamic>,
    );
    myCtrl.selectedCollege.value = myCtrl.userData.value.college;
    myCtrl.selectedBranch.value = myCtrl.userData.value.branch;
    myCtrl.selectedSemester.value = myCtrl.userData.value.semester;
    myCtrl.isDataLoaded.value = true;
  }

  //* Update Semester
  Future<bool> updateBranchSemester(
      {required String value, required String key}) async {
    try {
      var userData =
          await users.where('uid', isEqualTo: myCtrl.userData.value.id).get();
      var docID = userData.docs.first.id;
      users.doc(docID).update({key: value});
      var updatedUserData =
          await users.where('uid', isEqualTo: myCtrl.userData.value.id).get();
      myCtrl.userData.value = UserData.fromJson(
        updatedUserData.docs[0].data() as Map<String, dynamic>,
      );
      myCtrl.selectedSemester.value = myCtrl.userData.value.semester;
      myCtrl.selectedBranch.value = myCtrl.userData.value.branch;
      return true;
    } catch (e) {
      return false;
    }
  }

  //* Send message
  Future sendMessage(String message) async {
    try {
      await messages.add({
        'message': message,
        'uid': auth.currentUser!.uid,
        'name': auth.currentUser!.displayName,
        'college': myCtrl.selectedCollege.value,
        'branch': myCtrl.selectedBranch.value,
        'semester': myCtrl.selectedSemester.value,
        'phone': myCtrl.userData.value.phone,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  //* Add Notes
  Future<bool> addNote({
    required String filePath,
    required File file,
    required String name,
    required String subject,
    required String semester,
  }) async {
    try {
      final reference = FirebaseStorage.instance.ref().child("notes/$filePath");
      await reference.putFile(file);
      final notesUrl = await reference.getDownloadURL();
      await notes.add({
        'subject': subject,
        'name': name,
        'url': notesUrl,
        'branch': myCtrl.userData.value.branch,
        'semester': semester,
        'author': myCtrl.userData.value.id
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  //* Add youtube urls
  Future<bool> addYouTubeUrl({required String url, subject, semester}) async {
    try {
      await youtubeUrls.add({
        'url': url,
        'subject': subject,
        'semester': semester ?? myCtrl.userData.value.semester,
        'branch': myCtrl.userData.value.branch,
        'author': myCtrl.userData.value.id
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  String extractVideoId(String url) {
    RegExp regex = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
    );

    Match? match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      return '';
    }
  }

  //* Get youtube urls data
  Future<dynamic> getYoutubeData(String url) async {
    String videoId = extractVideoId(url);
    String uri = '$baseUrl/videos?id=$videoId&key=$apiKey&part=snippet';

    try {
      var res = await http.get(Uri.parse(uri));
      var data = jsonDecode(res.body);
      return YouTubeVideoData.fromJson(data);
    } catch (e) {
      throw 'Something wrong happened';
    }
  }
}
