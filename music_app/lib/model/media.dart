class Media {
  final String id;
  final String name;
  final String status;
  final String doi;
  final String musician;
  final String fileUrl;

  Media(this.id, this.name, this.status, this.doi,
      this.musician, this.fileUrl);

  static List<Media> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList
        .map((r) => Media(r['id'], r['name'], r['status'],
        r['doi'], r['musician'], r['fileUrl']))
        .toList();
  }
}