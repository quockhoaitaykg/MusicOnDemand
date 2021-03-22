class MediaProfile {
  final String id;
  final String name;
  final String status;
  final String doi;
  final String musician;
  final String fileUrl;

  MediaProfile(
      {this.id, this.name, this.status, this.doi, this.musician, this.fileUrl});

  factory MediaProfile.fromJson(Map<String, dynamic> json) {
    return MediaProfile(
        id: json['data']['id'],
        name: json['data']['name'],
        status: json['data']['status'],
        doi: json['data']['doi'],
        musician: json['data']['musician'],
        fileUrl: json['data']['fileUrl']);
  }
}
