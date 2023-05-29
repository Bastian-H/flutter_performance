//workload.dart

import 'dart:async';

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

Future<void> runCpuWorkload(Duration duration) async {
  int n = 35;
  int result = 0;
  DateTime startTime = DateTime.now();

  while (DateTime.now().difference(startTime) < duration) {
    result = fibonacci(n);
  }

  print('Fibonacci result: $result');
}

Future<void> runRamWorkload(Duration duration) async {
  List<String> largeStrings = [];
  int count = 1000;
  int size = 10000;
  DateTime startTime = DateTime.now();

  while (DateTime.now().difference(startTime) < duration) {
    largeStrings = generateLargeStrings(count, size);
  }

  print('Generated ${largeStrings.length} large strings');
}
