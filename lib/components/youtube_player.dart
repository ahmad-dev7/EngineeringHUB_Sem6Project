import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/model/youtube_video_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_video_player/potrait_player.dart';

class ShowYouTubeVideo extends StatelessWidget {
  final YouTubeVideoData videoData;
  final String url;
  const ShowYouTubeVideo(
      {super.key, required this.videoData, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PotraitPlayer(
                link: url,
                aspectRatio: 16 / 9,
                textColor: Theme.of(context).colorScheme.onBackground,
                primaryColor: Theme.of(context).colorScheme.onPrimary,
              ),
              ListTile(
                title: KMyText(videoData.title!, weight: FontWeight.bold),
                minVerticalPadding: 20,
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Opacity(
                    opacity: 0.8,
                    child: Linkify(
                      onOpen: (link) async {
                        if (!await launchUrl(Uri.parse(link.url))) {
                          throw Exception('Could not launch ${link.url}');
                        }
                      },
                      text: videoData.description ?? '',
                      linkStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
