import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/task_project_future.dart';
import 'package:productivity_app/screens/tasks/components/task_status_future.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/statuses_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TaskStream extends StatefulWidget {
  @override
  _TaskStreamState createState() => _TaskStreamState();
}

class _TaskStreamState extends State<TaskStream>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedPage = 0;
  Widget body;

  List<Widget> pages = [
    TaskStatusesFuture(), // TODO: fix this function call
    TaskProjectsFuture(),
  ];

  void setPage(int index, AsyncSnapshot<QuerySnapshot> querySnapshot) {
    setState(() {
      switch (selectedPage) {
        case 0:
          body = TaskStatusesFuture(querySnapshot: querySnapshot);
          break;
        case 1:
          body = TaskStatusesFuture(querySnapshot: querySnapshot);
          break;
        case 2:
          body = TaskStatusesFuture(querySnapshot: querySnapshot);
          break;
        case 3:
          body = TaskProjectsFuture(querySnapshot: querySnapshot);
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return StreamBuilder(
        stream: TaskService(user: user).tasks.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StatefulBuilder(builder:
                    (BuildContext context, StateSetter filterSetState) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton.icon(
                            onPressed: () {
                              filterSetState(() {
                                selectedPage = 0;
                                body = TaskStatusesFuture(querySnapshot: snapshot);
                              });
                              // setPage(0, snapshot);
                            },
                            icon: Icon(Icons.label_rounded),
                            label: Text('Status'),
                            style: TextButton.styleFrom(
                              backgroundColor: selectedPage == 0
                                  ? Theme.of(context).primaryColor
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton.icon(
                            onPressed: () {
                              filterSetState(() {
                                selectedPage = 1;
                                body = TaskStatusesFuture(querySnapshot: snapshot);
                              });
                              // setPage(1, snapshot);
                            },
                            icon: Icon(Icons.notification_important_rounded),
                            label: Text('Due Date'),
                            style: TextButton.styleFrom(
                              backgroundColor: selectedPage == 1
                                  ? Theme.of(context).primaryColor
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton.icon(
                            onPressed: () {
                              filterSetState(() {
                                selectedPage = 2;
                                body = TaskStatusesFuture(querySnapshot: snapshot);
                              });
                              // setPage(2, snapshot);
                            },
                            icon: Icon(Icons.playlist_add_rounded),
                            label: Text('Create Date'),
                            style: TextButton.styleFrom(
                              backgroundColor: selectedPage == 2
                                  ? Theme.of(context).primaryColor
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton.icon(
                            onPressed: () {
                              filterSetState(() {
                                selectedPage = 3;
                                body = TaskProjectsFuture(querySnapshot: snapshot);
                              });
                              // setPage(3, snapshot);
                            },
                            icon: Icon(Icons.topic_rounded),
                            label: Text('Project'),
                            style: TextButton.styleFrom(
                              backgroundColor: selectedPage == 3
                                  ? Theme.of(context).primaryColor
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Expanded(
                    child: body ?? TaskStatusesFuture(querySnapshot: snapshot))
              ],
            ),
          );
        });
  }
}
