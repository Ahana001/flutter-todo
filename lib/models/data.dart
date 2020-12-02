import 'dart:async';

var taskData = [
  {
    'title': 'Milosz Klimek',
    'info': 'assets/images/1.png',
    'date': 'UI Designer, Team Leader',
    'goalRatio': 83,
    'isDone': true,
  },
  {
    'title': 'Gabriela Bryndal',
    'info': 'assets/images/2.png',
    'date': 'Product Designer',
    'goalRatio': 81,
    'isDone': true,
  },
  {
    'title': 'Mateusz Przytula',
    'info': 'assets/images/3.png',
    'date': 'Product Designer',
    'goalRatio': 78,
    'isDone': true,
  },
  {
    'title': 'Patrycja Batko',
    'info': 'assets/images/4.png',
    'date': 'Frontend Developer',
    'goalRatio': 78,
    'isDone': false,
  },
  {
    'title': 'Marta Kolbusz',
    'info': 'assets/images/5.png',
    'date': 'Quality Assurance',
    'goalRatio': 79,
    'isDone': false,
  },
];

Future<List<dynamic>> fetchTask() {
  return Future.delayed(Duration(seconds: 3), () {
    return taskData;
  });
}
