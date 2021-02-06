import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/components/task_page/due_task_list_builder.dart';
import 'package:productivity_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/projects_data.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {

    return StreamProvider.value(
      value: ProjectService().projectsCollection,
      child: TaskTest()
    );
  }
}

class TaskTest extends StatefulWidget {
  @override
  _TaskTestState createState() => _TaskTestState();
}

class _TaskTestState extends State<TaskTest> {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Projects>>(context) ?? [];
    return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index].projectName),
            subtitle: Text(projects[index].projectID),
          );
        },
    );
  }
}
  // final List<String> projectList = [
  //   'project 1',
  //   'project 2',
  //   'project 3',
  //   'project 4',
  //   'project 5'
  // ];

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //       itemCount: projectList.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //             padding: EdgeInsets.all(5),
  //             child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: <Widget>[
  //                   ExpansionTile(
  //                     title: Text(projectList[index]),
  //                     children: [TasksDueToday()],
  //                   ),
  //                 ]));
  //       });
  // }
