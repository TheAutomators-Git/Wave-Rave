class Song {
  final String id;
  final String name;
  final String album;
  final String artist;
  final String image;

  Song({
    required this.id,
    required this.name,
    required this.album,
    required this.artist,
    required this.image,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    String truncate(String input, int maxLength) {
      if (input.length <= maxLength) {
        return input;
      } else {
        return input.substring(0, maxLength - 2) + " ..";
      }
    }

    return Song(
      id: json['id'],
      name: truncate(
          json['title'].replaceAll("&quot;", '"').replaceAll("&amp;", "&"), 30),
      album: truncate(
          json['album'].replaceAll("&quot;", '"').replaceAll("&amp;", "&"), 30),
      artist: truncate(
          json['more_info']['primary_artists']
              .replaceAll("&quot;", '"')
              .replaceAll("&amp;", "&"),
          30),
      image: json['image'],
    );
  }
}
