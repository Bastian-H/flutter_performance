//list_page.dart

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
      ),
      body: ListView.builder(
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
