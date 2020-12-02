import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/data.dart';
import 'package:todo/models/task.dart';
import 'package:todo/repository/firebase_repo.dart';

import 'package:todo/widgets/circle_indicator.dart';
import 'package:todo/widgets/progress_line_indicator.dart';

class TaskEditScreen extends StatefulWidget {
  final Task task;

  const TaskEditScreen({Key key, @required this.task}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  PageController _goalPageController;
  int _goalPageCurrent = 0;
  DateTime selectedDate = DateTime.now();

  Map<String, Object> taskJson = {};

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        taskJson['date'] = picked.toString().substring(0, 10);
      });
  }

  @override
  void initState() {
    super.initState();
    _goalPageController = PageController(viewportFraction: 0.9);
    taskJson['title'] = widget.task.title;
    taskJson['info'] = widget.task.info;
    taskJson['date'] = widget.task.date;
    taskJson['isDone'] = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                    color: Color(0xfffbfafd),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.table_view,
                              color: Color(0xff00a294),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              taskJson["title"] = value;
                            });
                          },
                          style: TextStyle(fontSize: 28),
                          initialValue: taskJson["title"],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.info_outline,
                              color: Color(0xff00a294),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              taskJson["info"] = value;
                            });
                          },
                          style: TextStyle(fontSize: 18),
                          initialValue: taskJson["info"],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Color(0xff00a294),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(taskJson["date"]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Personal goals',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'See all >',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      child: PageView.builder(
                        controller: _goalPageController,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 5,
                                    offset: Offset(0, 5),
                                  )
                                ]),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'iOS ARKit 2',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text('3/5')
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProgressLineIndicator(
                                  completedPercentage: (3 / 5 * 100).toInt(),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  strokeWidth: 5,
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: 5,
                        onPageChanged: (page) {
                          setState(() {
                            _goalPageCurrent = page;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleIndicator(
                      count: 5,
                      current: _goalPageCurrent,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Current tasks',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Calendar >',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 180,
                      child: PageView.builder(
                        controller: _goalPageController,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[400],
                                    blurRadius: 5,
                                    offset: Offset(0, 5),
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(80),
                                        color: Colors.greenAccent,
                                      ),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'TIS-12',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[300],
                                      ),
                                      child: Text(
                                        'In progress',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Mobile app UX Review',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.watch_later,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    Text(
                                      '26-04 (Friday)',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Text(
                                      '14 comments',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: 5,
                        onPageChanged: (page) {
                          setState(() {
                            _goalPageCurrent = page;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CircleIndicator(
                      count: 5,
                      current: _goalPageCurrent,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.,
        floatingActionButton: InkWell(
          onTap: () {
            taskJson["id"] = (Random().nextInt(1000)).toString();
            FirebaseTasksRepository().addNewTask(Task.fromJson(taskJson));
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 5),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.2),
                )
              ],
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.done,
              color: Color(0xff00a294),
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
