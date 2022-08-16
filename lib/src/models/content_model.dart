class ContentModel {
  final String? copyright;
  final String? date;
  final String? explanation;
  final String? mediaType;
  final String? serviceVersion;
  final String? title;
  final String? url;
  final String? thumbnailUrl;
  ContentModel({
    this.copyright,
    this.date,
    this.explanation,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  Map<dynamic, dynamic> toMap() {
    var map = <String, dynamic>{
      'Title': title,
      'Date': date,
      'Explanation': explanation,
      'Copyright': copyright,
    };
    if (mediaType == 'video') {
      map.addEntries(<String, dynamic>{'Video link': url}.entries);
    }
    return map;
  }

  factory ContentModel.fromMap(Map map) {
    return ContentModel(
      copyright: map['copyright'],
      date: map['date'],
      explanation: map['explanation'],
      mediaType: map['media_type'],
      serviceVersion: map['service_version'],
      title: map['title'],
      url: map['url'],
      thumbnailUrl: map['thumbnail_url'],
    );
  }
}
