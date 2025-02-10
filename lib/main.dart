import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:tesk/home/home_page.dart';

//https://images.pexels.com/photos/792381/pexels-photo-792381.jpeg

/// Entrypoint of the application.
void main() {
  setUrlStrategy(PathUrlStrategy());

  runApp(const MyApp());
}

/// Application itself.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const HomePage());
  }
}
