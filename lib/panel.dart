import 'package:flutter/material.dart';
import '/pages/home.dart';
import '/pages/library.dart';
import '/pages/search.dart';

enum Page { home, search, library }

class Panel extends StatefulWidget {
  const Panel({super.key});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  Page _selectedPage = Page.home;

  void _selectPage(Page page) {
    setState(() {
      _selectedPage = page;
    });
  }

  Widget _getPage(Page page) {
    switch (page) {
      case Page.home:
        return const Home();
      case Page.search:
        return const Search();
      case Page.library:
        return const Library();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: _getPage(_selectedPage),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () => _selectPage(Page.home),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => _selectPage(Page.search),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: IconButton(
                        icon: const Icon(Icons.library_books),
                        onPressed: () => _selectPage(Page.library),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
