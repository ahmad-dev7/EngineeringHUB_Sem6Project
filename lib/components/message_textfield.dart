import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_radius.dart';
import 'package:myapp/controller/my_controller.dart';

class MessageTextField extends StatelessWidget {
  final Function(String val) onSend;
  final bool? hidePrefix;
  const MessageTextField({super.key, required this.onSend, this.hidePrefix});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    var messageCtrl = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => TextField(
          controller: messageCtrl,
          onChanged: (value) => myCtrl.messageController.value = value,
          maxLines: 3,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: onSend,
          decoration: InputDecoration(
            hintText: 'Type your message...',
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.fromLTRB(10, 8, 0, 8),
            suffixIcon: Visibility(
              visible: myCtrl.messageController.value.isNotEmpty,
              child: IconButton(
                onPressed: () {
                  onSend(messageCtrl.text);
                  messageCtrl.clear();
                  myCtrl.messageController.value = '';
                },
                color: Theme.of(context).colorScheme.onBackground,
                icon: const Icon(Icons.send),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary),
              borderRadius: kRadius(),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary),
              borderRadius: kRadius(),
            ),
          ),
        ),
      ),
    );
  }
}
