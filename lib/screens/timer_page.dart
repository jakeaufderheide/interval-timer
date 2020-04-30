import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interval_timer/BLoC/timer_card_bloc.dart';
import 'package:interval_timer/constants.dart';
import 'package:interval_timer/models/card.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Card(
                child: SafeArea(
                  child: WorkoutCardContent(),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              BigControlButton(),
            ],
          ),
          SizedBox(
            height: 300,
          )
        ],
      ),
    );
  }
}

class BigControlButton extends StatelessWidget {
  const BigControlButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.pause,
        size: 50,
      ),
      onPressed: () => {
        timerCardBloc.toggle(),
      },
      elevation: 10.0,
      fillColor: Colors.red,
      shape: CircleBorder(),
      constraints: BoxConstraints(minWidth: 100.0, minHeight: 100.0),
    );
  }
}

class WorkoutCardContent extends StatefulWidget {
  const WorkoutCardContent({
    Key key,
  }) : super(key: key);

  @override
  _WorkoutCardContentState createState() => _WorkoutCardContentState();
}

class _WorkoutCardContentState extends State<WorkoutCardContent> {
  TimeCard card;

  @override
  void dispose() {
    timerCardBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    timerCardBloc.toggle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kStandardPadding),
      child: StreamBuilder(
        stream: timerCardBloc.timeCardStream,
        initialData: TimeCard(currentTimeSeconds: 0, isActive: false),
        builder: (context, snapshot) {
          card = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TopBar(),
              CircularTimer(currentSeconds: card.currentTimeSeconds),
            ],
          );
        },
      ),
    );
  }
}

class CircularTimer extends StatelessWidget {
  const CircularTimer({
    Key key,
    @required this.currentSeconds,
  }) : super(key: key);

  final int currentSeconds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kStandardPadding),
      child: SleekCircularSlider(
        innerWidget: (seconds) {
          var minutesTime = (seconds / 60).floor().toString().padLeft(2, '0');
          var secondsTime = (seconds % 60).toInt().toString().padLeft(2, '0');
          return Center(
            child: Text(
              '$minutesTime:$secondsTime',
              style: kTimerText,
            ),
          );
        },
        appearance: CircularSliderAppearance(
            animationEnabled: true,
            customColors: CustomSliderColors(
              progressBarColor: Colors.red,
              dotColor: Color.fromRGBO(0, 0, 0, 0),
              shadowColor: Colors.black,
              shadowMaxOpacity: .02,
              trackColor: Color.fromRGBO(0, 0, 0, 0),
            ),
            size: 250,
            customWidths: CustomSliderWidths(progressBarWidth: 30)),
        min: 0,
        max: 300.0,
        initialValue: currentSeconds.toDouble(),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Workout type',
            style: kHeaderText,
          ),
        ),
        RawMaterialButton(
          child: Icon(Icons.stop),
          onPressed: () => {},
          fillColor: Colors.red,
          shape: CircleBorder(),
          constraints: BoxConstraints(minWidth: 50.0, minHeight: 50.0),
        ),
      ],
    );
  }
}
