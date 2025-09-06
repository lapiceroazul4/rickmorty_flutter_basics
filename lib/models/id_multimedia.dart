class IdMultimedia {
  final String id;
  final String url;

  IdMultimedia({
    required this.id,
    required this.url,
  });

  factory IdMultimedia.fromJson(Map<String, dynamic> json) => IdMultimedia(
        id: json["_id"],
        url: json["url"],
      );
}
