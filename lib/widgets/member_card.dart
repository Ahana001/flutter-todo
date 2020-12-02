import 'package:flutter/material.dart';

import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/member_screen.dart';

import 'package:todo/screens/team_screen.dart';
import 'package:todo/widgets/circle_profile.dart';
import 'package:todo/widgets/progress_circle_indicator.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final int index;

  const TaskCard({Key key, this.index}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final task = taskProvider.taskList[widget.index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            blurRadius: 5,
            offset: Offset(0, 5),
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff00a294),
            Color(0xff01d468),
          ],
        ),
      ),
      child: Dismissible(
        key: Key(task.title),
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ],
          ),
        ),
        confirmDismiss: (dismissDirection) async {
          if (dismissDirection == DismissDirection.startToEnd) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return TaskEditScreen(
                    task: task,
                  );
                },
              ),
            );
          }

          if (dismissDirection == DismissDirection.endToStart) {
            taskProvider.delteTask(widget.index);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              action: SnackBarAction(
                label: "Yes",
                onPressed: () => taskProvider.undoDeleteTask(),
              ),
              content: Text("undo deleted task?"),
            ));
          }

          return false;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            color: Color(0xfffbfafd),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.title ?? "yf",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    task.date ?? "h",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Checkbox(
                activeColor: Color(0xff00a294),
                value: task.isDone,
                onChanged: (value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
