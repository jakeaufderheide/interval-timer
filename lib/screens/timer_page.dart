import 'package:flutter/material.dart';
import 'package:interval_timer/constants.dart';
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
          Expanded(
            child: Card(
              child: SafeArea(
                child: WorkoutCardContent(),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class WorkoutCardContent extends StatelessWidget {
  const WorkoutCardContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kStandardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TopBar(),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                  progressBarColor: Colors.red,
                  dotColor: Color.fromRGBO(0, 0, 0, 0),
                  shadowColor: Colors.black,
                  shadowMaxOpacity: .05,
                  trackColor: Colors.grey,
                ),
                size: 300,
                customWidths: CustomSliderWidths(progressBarWidth: 10)),
            min: 10,
            max: 28,
            initialValue: 20,
          ),
        ],
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
          child: Icon(Icons.play_arrow),
          onPressed: () => {},
          fillColor: Colors.red,
          shape: CircleBorder(),
          constraints: BoxConstraints(minWidth: 50.0, minHeight: 50.0),
        ),
      ],
    );
  }
}
