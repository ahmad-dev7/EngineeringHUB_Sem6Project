import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    final auth = FirebaseAuth.instance;
    Future<void> pickImage() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );
      if (image != null) {
        Reference reference = FirebaseStorage.instance
            .ref()
            .child('${auth.currentUser!.uid}profilePic.jpg');
        await reference.putFile(File(image.path));
        var imageUrl = await reference.getDownloadURL();
        reference.getDownloadURL().then((value) {
          auth.currentUser!.updatePhotoURL(imageUrl);
          myCtrl.activeScreen.value = 1;
          myCtrl.activeScreen.value = 2;
        });
      }
    }

    var user = FirebaseAuth.instance.currentUser!;
    return ListTile(
      minVerticalPadding: 10,
      contentPadding: const EdgeInsets.all(0),
      leading: InkWell(
        onTap: pickImage,
        child: ProfilePicture(
          name: user.displayName!,
          radius: 35,
          fontsize: 21,
          img: user.photoURL,
        ),
      ),
      title: KMyText(
        myCtrl.userData.value.name,
        weight: FontWeight.bold,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KMyText(myCtrl.userData.value.phone),
          KMyText(
            myCtrl.userData.value.email,
            overflow: TextOverflow.fade,
          ),
        ],
      ),
    );
  }
}
