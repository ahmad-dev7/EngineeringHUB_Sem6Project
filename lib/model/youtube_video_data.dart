class YouTubeVideoData {
  final String? thumbnailUrl;
  final String? title;
  final String? description;

  YouTubeVideoData({this.description, this.thumbnailUrl, this.title});

  factory YouTubeVideoData.fromJson(Map<String, dynamic> json) {
    var base = json['items'][0]['snippet'];
    return YouTubeVideoData(
      title: base['title'],
      description: base['description'],
      thumbnailUrl: base['thumbnails']['maxres']['url'],
    );
  }
}
