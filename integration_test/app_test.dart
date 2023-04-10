import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flutter Performance Test', () {
    final runs = 10;

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
        {int scrollDurationMs = 2000, double scrollDy = -300.0}) async {
      final gesture = await tester.drag(listFinder, Offset(0.0, scrollDy));
      await tester.pumpAndSettle(Duration(milliseconds: scrollDurationMs));
    }

    for (var i = 0; i < runs; i++) {
      testWidgets('List Page run $i', (tester) async {
        Trace trace = await startTrace('list_page_run_$i');
        await navigateToPage(tester, 'List Page');
        final listFinder = find.byType(ListView);
        await scrollPage(tester, listFinder);
        await navigateBack(tester);
        await trace.stop();
      });

      testWidgets('Image Page run $i', (tester) async {
        Trace trace = await startTrace('image_page_run_$i');
        await navigateToPage(tester, 'Image Page');
        final gridViewFinder = find.byType(GridView);
        await scrollPage(tester, gridViewFinder);
        await navigateBack(tester);
        await trace.stop();
      });

      testWidgets('Animation Page run $i', (tester) async {
        Trace trace = await startTrace('animation_page_run_$i');
        await navigateToPage(tester, 'Animation Page');
        // Optionally add performance measurements
        await navigateBack(tester);
        await trace.stop();
      });

      testWidgets('Network Page run $i', (tester) async {
        Trace trace = await startTrace('network_page_run_$i');
        await navigateToPage(tester, 'Network Page');
        // Optionally add performance measurements
        await navigateBack(tester);
        await trace.stop();
      });

      testWidgets('CPU Workload run $i', (tester) async {
        Trace trace = await startTrace('cpu_workload_run_$i');
        await navigateToPage(tester, 'CPU Workload');
        // Measure the duration of the CPU workload
        final Stopwatch stopwatch = Stopwatch()..start();
        await Future.delayed(Duration(seconds: 10));
        stopwatch.stop();
        print('CPU Workload duration: ${stopwatch.elapsedMilliseconds} ms');
        await navigateBack(tester);
        await trace.stop();
      });

      testWidgets('RAM Workload run $i', (tester) async {
        Trace trace = await startTrace('ram_workload_run_$i');
        await navigateToPage(tester, 'RAM Workload');
        // Measure the duration of the RAM workload
        final Stopwatch stopwatch = Stopwatch()..start();
        await Future.delayed(Duration(seconds: 10));
        stopwatch.stop();
        print('RAM Workload duration: ${stopwatch.elapsedMilliseconds} ms');
        await navigateBack(tester);
        await trace.stop();
      });
    }
  });
}

Future<Trace> startTrace(String name) async {
  FirebasePerformance firebasePerformance = FirebasePerformance.instance;
  Trace trace = firebasePerformance.newTrace(name);
  await trace.start();
  return trace;
}
