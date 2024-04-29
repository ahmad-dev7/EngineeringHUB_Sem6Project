import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/constants/k_date_chip.dart';
import 'package:myapp/constants/k_message_bubble.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/messages.dart';

class MessageBuilder extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  const MessageBuilder({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    var messageList = <Messages>[];
    final List<DocumentSnapshot> documents =
        snapshot.data?.docs.reversed.toList();
    for (DocumentSnapshot document in documents) {
      var data = document.data() as Map<String, dynamic>;
      messageList.add(Messages.fromSnapshot(data));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: messageList.length,
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          var isSender = messageList[index].uid == myCtrl.userData.value.id;
          var isLast = index == messageList.length - 1;
          var date = messageList[index].timestamp!.toDate();
          var tail = true;
          var showData = true;
          var showDateChip = true;
          final DateFormat formater = DateFormat('hh:mm a');
          if (index > 0) {
            tail = messageList[index - 1].uid != messageList[index].uid;
          }
          if (index < messageList.length - 1) {
            showData = messageList[index + 1].uid != messageList[index].uid;
          }
          if (index < messageList.length - 1) {
            if (messageList[index + 1].timestamp!.toDate().day != date.day) {
              showDateChip = true;
            } else {
              showDateChip = false;
            }
          }

          return Column(
            children: [
              Visibility(
                visible: showDateChip,
                child: KMyDateChip(
                  date: date,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              KMessageBubble(
                isSender: isSender,
                text: messageList[index].message,
                tail: tail,
                bottom: tail ? 20 : 2,
                showData: showData,
                isLast: isLast,
                timestmap: formater.format(date),
                name: messageList[index].name,
              ),
            ],
          );
        },
      ),
    );
  }
}
