import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_performance/main.dart' as app;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebasePerformance.instance.setPerformanceCollectionEnabled(true);

  final analytics = FirebaseAnalytics.instance;
  final observer = FirebaseAnalyticsObserver(analytics: analytics);

  runApp(app.MyApp(analytics: analytics, observer: observer));
}
