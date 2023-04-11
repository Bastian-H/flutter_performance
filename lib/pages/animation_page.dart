import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  late Ticker _ticker;
  int _frameCount = 0;
  int _fps = 0;
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    _frameCount++;

    // Calculate FPS every second
    if (elapsed.inMilliseconds % 1000 == 0) {
      _fps = _frameCount;
      _frameCount = 0;
    }

    // Update the angle of rotation
    _angle += 0.1;

    // Redraw the screen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Set time dilation to 1.0 for normal animation speed
    timeDilation = 1.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Page'),
      ),
      body: Center(
        child: Transform.rotate(
          angle: _angle,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Text('FPS: $_fps'),
        ),
      ),
    );
  }
}
