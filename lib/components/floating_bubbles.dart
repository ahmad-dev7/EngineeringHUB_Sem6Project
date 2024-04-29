import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/components/ad_youtube_url.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:myapp/components/add_file.dart';
import 'package:myapp/components/chat_bot.dart';
import 'package:myapp/constants/k_bubbles_builder.dart';
import 'package:myapp/constants/k_radius.dart';
import 'package:myapp/controller/animation_controller.dart';

class MyFloatingBubbles extends StatelessWidget {
  const MyFloatingBubbles({super.key});

  @override
  Widget build(BuildContext context) {
    var myAnimeCtrl = Get.put(MyAnimationController());
    myAnimeCtrl.controller.reset();
    return FloatingActionBubble(
      items: bubbleBuilder(
        context: context,
        onChatbotTap: () => Get.to(() => const ChatBot()),
        onAddFile: () => showBarModalBottomSheet(
          context: context,
          expand: false,
          builder: (_) => const AddFile(),
        ),
        onAddUrl: () => showStickyFlexibleBottomSheet(
          minHeight: 0.5,
          initHeight: 0.7,
          maxHeight: 0.85,
          headerHeight: 40,
          context: context,
          headerBuilder: (BuildContext context, double offset) {
            return Container(
              color: Theme.of(context).colorScheme.primary,
              child: Stack(
                children: [
                  Align(
                    child: Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: kRadius()),
                    ),
                  ),
                ],
              ),
            );
          },
          bodyBuilder: (BuildContext context, double offset) {
            return SliverChildListDelegate(
              <Widget>[
                const AddYouTubeUrl(),
              ],
            );
          },
          anchors: [0, 0.5, 0.85],
        ),
      ),
      animatedIconData: AnimatedIcons.list_view,
      onPress: () => myAnimeCtrl.controller.isCompleted
          ? myAnimeCtrl.controller.reverse()
          : myAnimeCtrl.controller.forward(),
      iconColor: Theme.of(context).colorScheme.onSecondary,
      backGroundColor: Theme.of(context).colorScheme.onPrimary,
      animation: myAnimeCtrl.animation,
    );
  }
}
