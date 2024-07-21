import 'package:flutter/material.dart';
import 'package:open_dual_view_example/home.dart';
import 'package:open_dual_view_example/package_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/packageNameList': (context) => const PackageListScreen()
      },
    );
  }
}
