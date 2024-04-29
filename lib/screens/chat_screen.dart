import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/chat_switcher.dart';
import 'package:myapp/components/message_stream.dart';
import 'package:myapp/components/message_textfield.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/services/services.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var services = BackendServices();
    var myCtrl = Get.put(MyController());
    sendMessage(String message) async {
      await services.sendMessage(message);
      myCtrl.messageController.value = '';
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ChatSwitcher(),
          const MessageStream(),
          MessageTextField(onSend: sendMessage),
        ],
      ),
    );
  }
}
