import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/youtube_cards.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/youtube_data.dart';

class YouTubeLinks extends StatelessWidget {
  final Stream? streamQuery;
  const YouTubeLinks({super.key, this.streamQuery});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Scaffold(
        body: StreamBuilder(
          stream: streamQuery ??
              FirebaseFirestore.instance
                  .collection('youtubeUrls')
                  .where('semester', isEqualTo: myCtrl.userData.value.semester)
                  .where('branch', isEqualTo: myCtrl.userData.value.branch)
                  .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              var document = snapshot.data?.docs.toList();
              var urlsData = <YouTubeData>[];
              for (var doc in document!) {
                urlsData.add(YouTubeData.fromJson(doc.data()));
              }
              return YouTubeCardsBuilder(urlsData: urlsData);
            } else {
              return const KMyText('No Urls available');
            }
          }),
        ),
      ),
    );
  }
}
