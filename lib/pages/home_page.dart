import 'package:flutter/material.dart';

import '../workload.dart';
import 'animation_page.dart';
import 'image_page.dart';
import 'list_page.dart';
import 'network_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Performance Test"),
      ),
      body: ListView(
        children: [
          ListTile(
            key: const Key('List Page'),
            title: const Text('List Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListPage()),
              );
            },
          ),
          ListTile(
            key: const Key("Image Page"),
            title: const Text("Image Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ImagePage()),
              );
            },
          ),
          ListTile(
            key: const Key("Animation Page"),
            title: const Text("Animation Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimationPage()),
              );
            },
          ),
          ListTile(
            key: const Key("Network Page"),
            title: const Text("Network Page"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NetworkPage()),
              );
            },
          ),
          ListTile(
            key: const Key("CPU Workload"),
            title: const Text("CPU Workload"),
            onTap: () {
              runCpuWorkload(const Duration(seconds: 10));
            },
          ),
          ListTile(
            key: const Key("RAM Workload"),
            title: const Text("RAM Workload"),
            onTap: () {
              runRamWorkload(const Duration(seconds: 10));
            },
          ),
        ],
      ),
    );
  }
}
