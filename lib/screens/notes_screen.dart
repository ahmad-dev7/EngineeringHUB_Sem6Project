import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/document_notes.dart';
import 'package:myapp/components/floating_bubbles.dart';
import 'package:myapp/components/youtube_links.dart';
import 'package:myapp/controller/animation_controller.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myAnimeCtrl = Get.put(MyAnimationController());
    myAnimeCtrl.controller.reset();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const MyFloatingBubbles(),
      body: ContainedTabBarView(
        tabs: const [
          SafeArea(child: Text('Document Notes')),
          SafeArea(child: Text('YouTube Url\'s')),
        ],
        views: const [
          DocumentNotes(),
          YouTubeLinks(),
        ],
        tabBarProperties: TabBarProperties(
          height: 80,
          unselectedLabelColor:
              Theme.of(context).colorScheme.secondary.withOpacity(.5),
          indicatorColor: Theme.of(context).colorScheme.onPrimary,
          labelColor: Theme.of(context).colorScheme.onSecondary,
          background: Container(color: Theme.of(context).colorScheme.primary),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}
