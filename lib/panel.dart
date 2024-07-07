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
        return Home();
      case Page.search:
        return Search();
      case Page.library:
        return Library();
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _getPage(_selectedPage),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Container(
                width: double.infinity,
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
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => _selectPage(Page.search),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
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
      ),
    );
  }
}
