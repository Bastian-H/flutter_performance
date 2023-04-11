import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_performance/main.dart';
import 'package:flutter_performance/workload.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

bool _initializedFirebase = false;
late FirebasePerformance _firebasePerformance;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _firebasePerformance = FirebasePerformance.instance;
  _initializedFirebase = true;

  group('Flutter Performance Test', () {
    const runs = 10;

    Future<void> _initializeApp(WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MyApp(
            analytics: FirebaseAnalytics.instance,
            observer: FirebaseAnalyticsObserver(
                analytics: FirebaseAnalytics.instance),
          ),
        );
      });

      await tester.pumpAndSettle();
    }

    testWidgets('Initialize App', _initializeApp);

    Future<void> navigateToPage(WidgetTester tester, String title) async {
      final listTile = find.byKey(ValueKey(title));
      await tester.tap(listTile);
      await tester.pumpAndSettle();
    }

    Future<void> navigateBack(WidgetTester tester) async {
      final backButton = find.byTooltip('Back');
      await tester.tap(backButton);
      await tester.pumpAndSettle();
    }

    Future<void> scrollPage(WidgetTester tester, Finder listFinder,
        {int scrollDurationMs = 10000, double scrollDy = -30000.0}) async {
      final gesture = await tester.startGesture(tester.getCenter(listFinder));
      final segmentSize = scrollDy.abs() / 10;
      final segments = (scrollDy.abs() / segmentSize).ceil();
      final segmentDuration = scrollDurationMs ~/ segments;
      for (int i = 0; i < segments; i++) {
        final dy = scrollDy < 0 ? -segmentSize : segmentSize;
        await gesture.moveBy(Offset(0, dy));
        await tester.pump(Duration(milliseconds: segmentDuration));
      }
    }

    final startupTrace = _firebasePerformance.newTrace('startup_time');
    startupTrace.start();

    for (var i = 0; i < runs; i++) {
      testWidgets('List Page run$i', (tester) async {
        await _initializeApp(tester);
        final listPageTrace = _firebasePerformance.newTrace('list_page_$i');
        listPageTrace.start();
        await navigateToPage(tester, 'List Page');
        await scrollPage(tester, find.byType(ListView));
        await navigateBack(tester);
        await tester.pumpWidget(
          MyApp(
            analytics: FirebaseAnalytics.instance,
            observer: FirebaseAnalyticsObserver(
                analytics: FirebaseAnalytics.instance),
          ),
        );
        listPageTrace.stop();
      });

      // testWidgets('Image Page run $i', (tester) async {
      //   final imagePageTrace = _firebasePerformance.newTrace('image_page_$i');
      //   imagePageTrace.start();
      //   await navigateToPage(tester, 'Image Page');
      //   await scrollPage(tester, find.byType(ListView));
      //   await navigateBack(tester);
      //   imagePageTrace.stop();
      // });

      // testWidgets('Animation Page run $i', (tester) async {
      //   final animationPageTrace =
      //       _firebasePerformance.newTrace('animation_page_$i');
      //   animationPageTrace.start();
      //   final fpsCounter = FpsCounter();
      //   final ticker = Ticker((elapsed) {
      //     fpsCounter.addFrame(elapsed);
      //   });
      //   ticker.start();
      //   await navigateToPage(tester, 'Animation Page');
      //   await Future.delayed(Duration(seconds: 5));
      //   await navigateBack(tester);
      //   ticker.stop();
      //   animationPageTrace.putAttribute(
      //       'FPS', fpsCounter.averageFps.toString());
      //   animationPageTrace.stop();
      // });

      // testWidgets('Network Page run $i', (tester) async {
      //   final networkPageTrace =
      //       _firebasePerformance.newTrace('network_page_$i');
      //   networkPageTrace.start();
      //   await navigateToPage(tester, 'Network Page');
      //   await Future.delayed(Duration(seconds: 2));
      //   await navigateBack(tester);
      //   networkPageTrace.stop();
      // });
    }

    // final cpuTrace = _firebasePerformance.newTrace('cpu_workload');

    // cpuTrace.start();
    // runCpuWorkload(const Duration(seconds: 30));
    // cpuTrace.stop();

    // final ramTrace = _firebasePerformance.newTrace('ram_workload');
    // ramTrace.start();
    // runRamWorkload(const Duration(seconds: 30));
    // ramTrace.stop();

    // startupTrace.stop();
  });
}

class FpsCounter {
  static const frameCount = 120;

  final _frameTimes = List.filled(frameCount, Duration.zero);
  int _currentIndex = 0;

  void addFrame(Duration elapsed) {
    _frameTimes[_currentIndex] = elapsed;
    _currentIndex = (_currentIndex + 1) % frameCount;
  }

  double get averageFps {
    final totalSeconds =
        _frameTimes.last.inMicroseconds / Duration.microsecondsPerSecond;
    final frameCount = _frameTimes.length - 1;
    final fps = frameCount / totalSeconds;
    return fps.isFinite ? fps : 0;
  }
}
