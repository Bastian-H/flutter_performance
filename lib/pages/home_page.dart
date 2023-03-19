// pages/home_page.dart
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
            title: Text("List Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage()),
              );
            },
          ),
          ListTile(
            title: Text("Image Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImagePage()),
              );
            },
          ),
          ListTile(
            title: Text("Animation Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnimationPage()),
              );
            },
          ),
          ListTile(
            title: Text("Network Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NetworkPage()),
              );
            },
          ),
          ListTile(
            title: Text("CPU Workload"),
            onTap: () {
              runCpuWorkload(Duration(seconds: 10));
            },
          ),
          ListTile(
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
