import 'dart:async';
import 'package:interval_timer/BLoC/bloc.dart';
import 'package:interval_timer/constants.dart';
import 'package:interval_timer/models/card.dart';

class TimerCardBloc implements Bloc {
  bool _isActive = false;
  int _currentTimeSeconds = kInitialValueSeconds;

  final _currentTimeController = StreamController<TimeCard>();
  Stream<TimeCard> get timeCardStream => _currentTimeController.stream;

  Timer timer;
  void _start() {
    _isActive = true;
    _publishState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTimeSeconds--;
      if (_currentTimeSeconds == 0) {
        stop();
        return;
      }
      _publishState();
    });
  }

  void _pause() {
    _isActive = false;
    timer.cancel();
    _publishState();
  }

  @override
  void dispose() {
    _currentTimeController.close();
  }

  void updateTime(int value) {
    _currentTimeSeconds = value;
    _publishState();
  }

  void toggle() {
    if (!_isActive) {
      _start();
    } else {
      _pause();
    }
  }

  void stop() {
    _currentTimeSeconds = kInitialValueSeconds;
    _pause();
  }

  void _publishState() {
    _currentTimeController.sink.add(TimeCard(
      currentTimeSeconds: _currentTimeSeconds,
      isActive: _isActive,
    ));
  }
}

final timerCardBloc = TimerCardBloc();
