import 'package:flutter/material.dart';

import '../workload.dart';
import 'animation_page.dart';
import 'image_page.dart';
import 'list_page.dart';
import 'network_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Performance Test"),
      ),
      body: ListView(
        children: [
          ListTile(
            key: Key("List Page"),
            title: Text("List Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage()),
              );
            },
          ),
          ListTile(
            key: Key("Image Page"),
            title: Text("Image Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImagePage()),
              );
            },
          ),
          ListTile(
            key: Key("Animation Page"),
            title: Text("Animation Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimationPage()),
              );
            },
          ),
          ListTile(
            key: Key("Network Page"),
            title: Text("Network Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NetworkPage()),
              );
            },
          ),
          ListTile(
            key: Key("CPU Workload"),
            title: Text("CPU Workload"),
            onTap: () {
              runCpuWorkload(Duration(seconds: 10));
            },
          ),
          ListTile(
            key: Key("RAM Workload"),
            title: Text("RAM Workload"),
            onTap: () {
              runRamWorkload(Duration(seconds: 10));
            },
          ),
        ],
      ),
    );
  }
}
