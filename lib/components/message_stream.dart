import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/message_builder.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/services/services.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    var services = BackendServices();
    var myCtrl = Get.put(MyController());

    return Obx(
      () => StreamBuilder(
        stream: services.messages
            .where('college', isEqualTo: myCtrl.selectedCollege.value)
            .where('branch', isEqualTo: myCtrl.selectedBranch.value)
            .where('semester', isEqualTo: myCtrl.selectedSemester.value)
            .orderBy('timestamp')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return MessageBuilder(snapshot: snapshot);
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          } else {
            return const Center(
              child: Text('No message here yet...\n Start conversation'),
            );
          }
        },
      ),
    );
  }
}
