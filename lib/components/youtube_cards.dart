import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/youtube_player.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_radius.dart';
import 'package:myapp/model/youtube_data.dart';
import 'package:myapp/model/youtube_video_data.dart';
import 'package:myapp/services/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

//* Playlist url
//? https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistId&key=$apiKey

//* Video Url
//? https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$apiKey&part=snippet

//* Channel logo
//? https://www.googleapis.com/youtube/v3/channels?part=snippet&id=$channelId&key=$apiKey

class YouTubeCardsBuilder extends StatelessWidget {
  final List<YouTubeData> urlsData;
  const YouTubeCardsBuilder({super.key, required this.urlsData});

  @override
  Widget build(BuildContext context) {
    var services = BackendServices();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DynamicHeightGridView(
        itemCount: urlsData.length,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        crossAxisCount: ResponsiveBreakpoints.of(context).isMobile
            ? 1
            : ResponsiveBreakpoints.of(context).isTablet
                ? 2
                : 3,
        builder: ((context, index) {
          return FutureBuilder(
            future: services.getYoutubeData(urlsData[index].url!),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                YouTubeVideoData data = snapshot.data;
                String thumbnailUrl = data.thumbnailUrl!;
                return InkWell(
                  onTap: () {
                    try {
                      Get.to(
                        ShowYouTubeVideo(
                          videoData: data,
                          url: urlsData[index].url!,
                        ),
                      );
                    } catch (e) {
                      launchUrl(Uri.parse(urlsData[index].url!));
                    }
                  },
                  child: Card(
                    elevation: 20,
                    color: Theme.of(context).colorScheme.primary,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: kRadius(radius: 14),
                            child: Image.network(thumbnailUrl),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: 200,
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black26,
                                    Colors.black38,
                                    Colors.black54,
                                    Colors.black87,
                                    Colors.black
                                  ],
                                ),
                              ),
                              child: KMyText(
                                data.title!,
                                weight: FontWeight.bold,
                                maxLines: 2,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const KMyText('No YouTube Url founds');
            },
          );
        }),
      ),
    );
  }
}
