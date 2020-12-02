import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/member_screen.dart';
import 'package:todo/widgets/member_card.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Text(
              'Your dream team',
              style: Theme.of(context).appBarTheme.textTheme.title,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Group of 5 will make it happen.',
              style: Theme.of(context).appBarTheme.textTheme.subtitle,
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Task>>(
        future: taskProvider.getTask(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) {
            List<Task> data = snapshot.data;

            if (data.isEmpty) {
              return Center(child: Text("Hurray!!! No task left!!!"));
            }

            return ListView.builder(
              itemBuilder: (_, index) {
                print(data[index].title??"");
                return TaskCard(index: index);
              },
              itemCount: data.length,
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => TaskEditScreen(
              task: Task(
                title: "add title here",
                info: "add your task info",
                date: "select due date",
                isDone: false,
              ),
            ),
          ));
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
            Icons.add,
            color: Color(0xff00a294),
            size: 50,
          ),
        ),
      ),
    );
  }
}
