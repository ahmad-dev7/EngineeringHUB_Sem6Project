import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/add_note_request.dart';
import 'package:myapp/components/document_notes.dart';
import 'package:myapp/components/update_button.dart';
import 'package:myapp/components/user_info.dart';
import 'package:myapp/components/youtube_links.dart';
import 'package:myapp/constants/k_items_list.dart';
import 'package:myapp/constants/k_my_page_container.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/user_data.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/theme/theme_changer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return KMyPageContainer(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User data
              const UserDetails(),
              const KVerticalSpace(height: 30),
              // Update branch/semester
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UpdateButton(
                    buttonKey: 'semester',
                    title: 'Update Semester',
                    buttonHint: 'Select Semester',
                    itemList: semesterList,
                    hideSearch: true,
                    buttonText: 'Update Semester',
                  ),
                  UpdateButton(
                    buttonKey: 'branch',
                    title: 'Update Branch',
                    buttonHint: 'Select Branch',
                    itemList: branchList,
                    hideSearch: false,
                    buttonText: 'Update Branch',
                  )
                ],
              ),
              const KVerticalSpace(height: 30),
              // Add Note Instruction
              const AddNoteRequest(),
              const KVerticalSpace(),
              const KMyText('Files you have added'),
              SizedBox(
                height: 250,
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: DocumentNotes(
                    streamQuery: FirebaseFirestore.instance
                        .collection('notes')
                        .where('author', isEqualTo: myCtrl.userData.value.id)
                        .snapshots(),
                  ),
                ),
              ),
              const KVerticalSpace(),
              const KMyText('Links you have added'),
              SizedBox(
                height: 250,
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: YouTubeLinks(
                      streamQuery: FirebaseFirestore.instance
                          .collection('youtubeUrls')
                          .where('author', isEqualTo: myCtrl.userData.value.id)
                          .snapshots(),
                    ),
                  ),
                ),
              ),

              const KVerticalSpace(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Get.offAll(() => const LoginScreen());
                      myCtrl.userData.value = UserData();
                      myCtrl.activeScreen.value = 0;
                    },
                    child: const Chip(
                      label: KMyText('Logout'),
                      side: BorderSide.none,
                      avatar: Icon(Icons.logout, color: Colors.white),
                      backgroundColor: Colors.red,
                    ),
                  ),
                  const ThemeChanger(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
