import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';

class SongService {
  static const String baseUrl = "https://www.jiosaavn.com/api.php";
  static const String queryParams =
      "?__call=autocomplete.get&_format=json&_marker=0&cc=in&includeMetaTags=1&query=";
  static int count = 0;

  static Future<List<Song>> getSongs(String query) async {
    final url = Uri.parse(baseUrl + queryParams + Uri.encodeComponent(query));
    List<Song> songs = [];

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['songs'] != null && data['songs']['data'] != null) {
          songs = (data['songs']['data'] as List)
              .map((song) => Song.fromJson(song))
              .toList();
        }
        count = 0; // Reset the counter on success
      } else {
        throw Exception('Failed to load songs');
      }
    } catch (e) {
      count += 1;
      if (count < 5) {
        print("ERROR: $count");
        return await getSongs(query); // Retry
      } else {
        print("Failed to load songs after 5 attempts");
      }
    }

    return songs;
  }
}
