import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer
import '../api/data.dart';
import '../models/song.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  List<Song> _songs = [];
  bool _issearching = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(seconds: 1), () {
        _searchSongs(_controller.text);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _searchSongs(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        _issearching = false;
        _songs = [];
      });
      return;
    }
    setState(() {
      _issearching = true;
      _songs = [];
    });
    final songs = await SongService.getSongs(searchText);
    setState(() {
      _issearching = false;
      _songs = songs;
    });
  }

  void _handleSongTap(String songId) {
    print('Song ID: $songId');
    print('This needs to be Played');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(100, 87, 75, 100),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Search for songs',
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            _issearching
                ? const Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        CircularProgressIndicator(),
                        Spacer()
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _songs.length,
                      itemBuilder: (context, index) {
                        final song = _songs[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextButton(
                            onPressed: () => _handleSongTap(song.id),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(100, 87, 75, 100),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: Row(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  song.image,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    song.artist,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
