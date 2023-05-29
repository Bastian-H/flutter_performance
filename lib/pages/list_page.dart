//list_page.dart

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  late ScrollController scrollController;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _startTime = DateTime.now();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_startTime != null) {
        print('Page load time: ${DateTime.now().difference(_startTime!)}');
        _startTime = null; // Prevents multiple prints
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: 1000,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/seed/${index + 1}/50'),
            ),
            title: Text('Item $index'),
            subtitle: Text('Subtitle for item $index'),
          );
        },
      ),
    );
  }
}
