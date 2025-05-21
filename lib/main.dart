import 'package:flutter/material.dart';
import 'screens/course_screen.dart';

void main() {
  runApp(const CataliftApp());
}

class CataliftApp extends StatelessWidget {
  const CataliftApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalift',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0A0A4A),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0A0A4A)),
      ),
      home: CoursesScreen(),
    );
  }
}
