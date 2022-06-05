import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'CircularStd',
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(),
    );
  }
}
