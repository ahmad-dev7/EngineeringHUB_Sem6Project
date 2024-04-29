class Notes {
  String? subject;
  String? name;
  String? url;
  String? branch;
  String? semester;

  Notes({this.subject, this.name, this.url, this.branch, this.semester});

  // Notes model from json
  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      subject: json['subject'],
      name: json['name'],
      url: json['url'],
      branch: json['branch'],
      semester: json['semester'],
    );
  }
}
