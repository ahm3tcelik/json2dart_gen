import 'package:flutter/material.dart';
import 'package:json2dart_gen/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter | Dart 💪 json2dart_gen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF6667AB,
          <int, Color>{
            50: Color(0xFF6667AB),
            100: Color(0xFF6667AB),
            200: Color(0xFF6667AB),
            300: Color(0xFF6667AB),
            400: Color(0xFF6667AB),
            500: Color(0xFF6667AB),
            600: Color(0xFF6667AB),
            700: Color(0xFF6667AB),
            800: Color(0xFF6667AB),
            900: Color(0xFF6667AB),
          },
        ),
      ),
      home: const HomeView(),
    );
  }
}
