//workload.dart

import 'dart:async';
import 'package:flutter/material.dart';

int fibonacci(int n) {
  if (n <= 1) {
    return n;
  } else {
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}

List<String> generateLargeStrings(int count, int size) {
  List<String> largeStrings = [];

  for (int i = 0; i < count; i++) {
    largeStrings.add(List.generate(size, (index) => 'A').join());
  }

  return largeStrings;
}

Future<void> runCpuWorkload(BuildContext context) async {
  int n = 44;

  Future<void> workloadFuture = Future<void>(() {
    DateTime startTime = DateTime.now();
    int result = fibonacci(n);
    DateTime endTime = DateTime.now();
    Duration computationTime = endTime.difference(startTime);

    print('Fibonacci result: $result');
    print(
        'Computation time: ${computationTime.inSeconds.toString().padLeft(2, '0')}.${(computationTime.inMilliseconds % 1000).toString().padLeft(3, '0')} seconds');
  });

  Future<void> delayFuture = Future.delayed(const Duration(seconds: 10));

  await Future.wait([workloadFuture, delayFuture]);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('CPU Workload Completed')),
  );
}

Future<void> runRamWorkload(BuildContext context, Duration duration) async {
  List<String> largeStrings = [];
  int count = 1000;
  int size = 10000;

  Future<void> workloadFuture = Future<void>(() {
    DateTime startTime = DateTime.now();

    while (DateTime.now().difference(startTime) < duration) {
      largeStrings = generateLargeStrings(count, size);
    }

    print('Generated ${largeStrings.length} large strings');
  });

  Future<void> delayFuture = Future.delayed(const Duration(seconds: 10));

  await Future.wait([workloadFuture, delayFuture]);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('RAM Workload Completed')),
  );
}

Future<void> runCpuWorkloadFixedTime(
    BuildContext context, Duration duration) async {
  int n = 20; // A smaller Fibonacci number that can be computed quickly
  int count = 0;

  Future<void> workloadFuture = Future<void>(() {
    DateTime startTime = DateTime.now();

    while (DateTime.now().difference(startTime) < duration) {
      fibonacci(n);
      count++;
    }

    print('Computed $count Fibonacci numbers in 10 seconds');
  });

  Future<void> delayFuture = Future.delayed(const Duration(seconds: 10));

  await Future.wait([workloadFuture, delayFuture]);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('CPU Workload (Fixed Time) Completed')),
  );
}
