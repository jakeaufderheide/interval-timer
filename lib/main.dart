import 'package:flutter/material.dart';

import 'screens/timer_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interval Timer',
      theme: ThemeData.dark(),
      home: TimerPage(),
    );
  }
}
