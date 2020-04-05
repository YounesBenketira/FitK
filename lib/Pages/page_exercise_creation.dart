import 'package:fit_k/Enums/cardTheme.dart';
import 'package:fit_k/Enums/workout.dart';
import 'package:fit_k/Logic/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseCreator extends StatefulWidget {
  Function addExercise;

  ExerciseCreator({Key key, this.addExercise}) : super(key: key);

  @override
  _ExerciseCreatorState createState() => _ExerciseCreatorState();
}

class _ExerciseCreatorState extends State<ExerciseCreator> {
  static List shoulders = [
    'Arnold Dumbbell Press',
    'Overhead Press',
    'Seated Dumbbell Press',
    'Log Press',
    'One Arm Standing Dumbbell Press',
    'Push Press',
    'Front Dumbbell Raise',
    'Lateral Raise',
    'Rear Delt Dumbbell Raise',
    'Face Pull',
    'Rear Delt Fly',
  ];

  static List triceps = [
    "Triceps Extension",
    "Close Grip Bench Press",
    "Overhead Triceps Extension",
    "Skullcrusher",
    "Triceps Dip",
    "Rope PushDown",
    "VBar PushDown"
  ];

  static List biceps = [
    "Barbell Curl",
    "Cable Curl",
    "Dumbbell Curl",
    "Concentration Curl",
    "Hammer Curl",
    "Preacher Curl",
    "Incline Dumbbell Curl",
    "Machine Curl",
  ];

  static List chest = [
    "Cable Crossover",
    "Decline Bench Press",
    "Bench Press",
    "Dumbbell Fly",
    "Incline Bench Press",
    "Incline Dumbbell Fly",
    "Machine Fly",
  ];

  static List back = [
    "Barbell Row",
    "Barbell Shrug",
    "Dumbbell Shrug",
    "Chin Up",
    "Deadlift",
    "Dumbbell Row",
    "Good Morning",
    "Hammer-Strength Row",
    "LatPulldown",
    "Pendlay Row",
    "Pull Up",
    'Rack Pull',
    'Seated Cable Row',
    'Cable Pushdown',
  ];

  static List legs = [
    'Barbell Front Squat',
    'Barbell Glute Bridge',
    'Barbell Squat',
    'Donkey Calf Raise',
    'Glute Ham Raise',
    'Leg Extension',
    'Leg Press',
    'Leg Curl',
    'Romanian Deadlift',
    'Seated Calf Raise',
    'Standing Calf Raise',
    'Stiff Legged Deadlift',
    'Sumo Deadlift',
  ];

  static List abs = [
    'Ab-Wheel Rollout',
    'Cable Crunch',
    'Crunch',
    'Decline Crunch',
    'Dragon Flag',
    'Hanging Knee Raise',
    'Hanging Leg Raise',
    'Plank',
    'Side Plank',
  ];

  static List cardio = [
    'Cycling',
    'Elliptical',
    'Rowing Machine',
    'Running',
    'Bike',
    'Swimming',
    'Walking',
  ];

  static List<Map> data = [
    {'Category': 'Shoulders', 'Exercises': shoulders},
    {'Category': 'Triceps', 'Exercises': triceps},
    {'Category': 'Biceps', 'Exercises': biceps},
    {'Category': 'Chest', 'Exercises': chest},
    {'Category': 'Back', 'Exercises': back},
    {'Category': 'Legs', 'Exercises': legs},
    {'Category': 'Abs', 'Exercises': abs},
    {'Category': 'Cardio', 'Exercises': cardio},
  ];

  List categories = [
    'Shoulders',
    'Triceps',
    'Biceps',
    'Chest',
    'Back',
    'Legs',
    'Abs',
    'Cardio'
  ];

  List colors = [
    Colors.lightBlue[500],
    Colors.greenAccent[700],
    Colors.deepOrange[500],
    Colors.purpleAccent[700],
    Colors.yellow[700],
  ];

  List allExercises = List();
  List displayData;
  String _title;
  int _index = 0;

  @override
  void initState() {
    for (int i = 0; i < data.length; i++)
      allExercises.addAll(data[i]['Exercises']);

    displayData = categories;

    _title = 'Select Category';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
//        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            setState(() {
              _index--;
              _changeList(displayData);
//              print(_index);
            });
          },
        ),
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            _title,
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  _index = 1;
                  if (text != '') {
                    displayData = allExercises.where((entry) {
                      return entry.toLowerCase().contains(text);
                    }).toList();
                    _title = 'Select Exercise';
                  } else {
                    displayData = categories;
                    _index = 0;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Exercise',
              ),
            ),
          ),
          _buildList(displayData),
        ],
      ),
    );
  }

  Workout selectedWorkout;
  bool workoutNotSet = true;
  ColorTheme selectedColor;
  String selectedExercise;

  void _changeList(var selected) {
    switch (_index) {
      case -1: // Show Category
        Navigator.of(context).pop();
        break;
      case 0: // Show Category
        setState(() {
          displayData = categories;
          _title = 'Select Category';
        });
        break;
      case 1: // Show Exercise List
        if (selected is String) {
          selectedExercise = selected;
          for (int i = 0; i < data.length; i++) {
            if (data[i]['Category'] == selectedExercise) {
              setState(() {
                displayData = data[i]['Exercises'];
                _title = 'Select Exercise';
              });
              return;
            }
          }
        } else if (selected is List) {
          if (selectedExercise == null) {
            setState(() {
              displayData = categories;
              _title = 'Select Category';
            });
            _index = 0;
          } else {
            for (int i = 0; i < data.length; i++) {
              if (data[i]['Category'] == selectedExercise) {
                setState(() {
                  displayData = data[i]['Exercises'];
                  _title = 'Select Exercise';
                });
                return;
              }
            }
          }
        }
        break;
      case 2: // Show Colors
        if (selected is! List)
          selectedWorkout = Workout.values.firstWhere(
              (e) => e.toString().substring(8) == selected.replaceAll(' ', ''));
        setState(() {
          displayData = colors;
          _title = 'Select Color';
        });
        break;
      case 3: // Create Exercise and change screens
        Color temp = selected;
        if (temp == Color(0xfffbc02d)) // yellow
          selectedColor = ColorTheme.Yellow;
        else if (temp == Color(0xff03a9f4)) // blue
          selectedColor = ColorTheme.Blue;
        else if (temp == Color(0xffaa00ff)) // purple
          selectedColor = ColorTheme.Purple;
        else if (temp == Color(0xffff5722)) // peach
          selectedColor = ColorTheme.Peach;
        else if (temp == Color(0xff00c853)) // green
          selectedColor = ColorTheme.Green;

        Exercise exercise =
            Exercise(workout: selectedWorkout, theme: selectedColor);

        widget.addExercise(exercise);

        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (_) => false,
        );
        break;
    }

//    switch (_index) {
//      case -1: // Show Categories
//        setState(() {
//          displayData = categories;
//          _title = 'Select Category';
//        });
//
//        break;
//      case 0: // Show Exercise List
//        for (int i = 0; i < data.length; i++) {
//          if (data[i]['Category'] == selected) {
//            setState(() {
//              displayData = data[i]['Exercises'];
//              _title = 'Select Exercise';
//            });
//
//            return;
//          }
//        }
//        break;
//      case 1: // Show Color List
//        if(selected is !List)
//          selectedWorkout = Workout.values.firstWhere(
//              (e) => e.toString().substring(8) == selected.replaceAll(' ', ''));
//        setState(() {
//          displayData = colors;
//          _title = 'Select Color';
//        });
//
//        break;
//      case 2:
//        Color temp = selected;
//        if (temp == Color(0xfffbc02d)) // yellow
//          selectedColor = ColorTheme.Yellow;
//        else if (temp == Color(0xff03a9f4)) // blue
//          selectedColor = ColorTheme.Blue;
//        else if (temp == Color(0xffaa00ff)) // purple
//          selectedColor = ColorTheme.Purple;
//        else if (temp == Color(0xffff5722)) // peach
//          selectedColor = ColorTheme.Peach;
//        else if (temp == Color(0xff00c853)) // green
//          selectedColor = ColorTheme.Green;
//
//        Exercise exercise =
//            Exercise(workout: selectedWorkout, theme: selectedColor);
//
//        widget.addExercise(exercise);
//
//        Navigator.of(context).pushNamedAndRemoveUntil(
//          '/',
//          (_) => false,
//        );
//        break;
//    }
  }

  Widget _buildList(List display) {
    return Column(
      children: <Widget>[
        ...display.map((entry) {
          return Container(
            width: double.infinity,
            child: FlatButton(
//                elevation: 2,
//              color: Colors.blue,
              child: Align(
                alignment: Alignment.centerLeft,
                child: entry is String
                    ? FittedBox(
                        child: Text(
                          entry,
                          style:
                              TextStyle(fontSize: 20, fontFamily: "OpenSans"),
                        ),
                      )
                    : Container(
                        color: entry,
                        width: double.infinity,
                        height: 30,
                      ),
              ),
              onPressed: () {
                _index++;
                _changeList(entry);
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}
