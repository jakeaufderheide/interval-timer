import 'package:flutter/material.dart';

class TimeCard {
  TimeCard({@required this.currentTimeSeconds, @required this.isActive});
  final bool isActive;
  final int currentTimeSeconds;
}
