import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myapp/components/message_textfield.dart';
import 'package:myapp/constants/k_message_bubble.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/bots_chat.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    var apiKey = 'AIzaSyD1qQ2mtv-QegFPYGo-t--1Xfh32h4IJW4';
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    var myCtrl = Get.put(MyController());
    // myCtrl.chat.clear();
    if (myCtrl.chat.isEmpty) {
      myCtrl.chat.add(
        BotsChat(
          isUser: false,
          message: 'Hello, ${myCtrl.userData.value.name} how can I help you?',
          date: DateTime.now(),
        ),
      );
    }

    Future<void> sendQuestion(String question) async {
      myCtrl.chat.addAll([
        BotsChat(
          isUser: true,
          message: question,
          date: DateTime.now(),
        ),
        BotsChat(
          isUser: false,
          message: 'Thinking...',
          date: DateTime.now(),
        ),
      ]);
      final content = [Content.text(question)];
      final response = await model.generateContent(content);
      myCtrl.chat.removeLast();
      myCtrl.chat.add(
        BotsChat(
          isUser: false,
          message: response.text ?? "",
          date: DateTime.now(),
        ),
      );
      myCtrl.chat.reversed.toList();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset('images/Google_Gemini_logo.png', height: 45),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton.filled(
            onPressed: () {
              myCtrl.chat.clear();
              myCtrl.chat.add(
                BotsChat(
                  isUser: false,
                  message:
                      'Hello, ${myCtrl.userData.value.name} how can I help you?',
                  date: DateTime.now(),
                ),
              );
            },
            icon: const Icon(Icons.restore),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const KVerticalSpace(),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: myCtrl.chat.length,
                // shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return KMessageBubble(
                    isSender: myCtrl.chat[index].isUser,
                    text: myCtrl.chat[index].message,
                    tail: true,
                    timestmap: myCtrl.chat[index].date.toString(),
                    bottom: 2,
                    showData: false,
                    isLast: false,
                    name: myCtrl.chat[index].isUser ? 'You' : 'Bot',
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: MessageTextField(onSend: sendQuestion, hidePrefix: true),
          ),
        ],
      ),
    );
  }
}
