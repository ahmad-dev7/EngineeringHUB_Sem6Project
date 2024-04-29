class YouTubeData {
  final String? url;
  final String? subject;
  final String? branch;
  final String? semester;

  YouTubeData({this.url, this.subject, this.branch, this.semester});

  factory YouTubeData.fromJson(Map<String, dynamic> json) {
    return YouTubeData(
      url: json['url'],
      subject: json['subject'],
      branch: json['branch'],
      semester: json['semester'],
    );
  }
}
