import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  int isSelected = 1;
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
            child: DefaultTabController(

              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter filterSetState) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  filterSetState(() {
                                    isSelected = 1;
                                  });
                                },
                                icon: Icon(Icons.label_rounded),
                                label: Text('Status'),
                                style: ElevatedButton.styleFrom(
                                  primary: isSelected == 1
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                  elevation: 1,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  filterSetState(() {
                                    isSelected = 2;
                                  });
                                },
                                icon: Icon(Icons.notification_important_rounded),
                                label: Text('Due Date'),
                                style: ElevatedButton.styleFrom(
                                  primary: isSelected == 2
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                  elevation: 1,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  filterSetState(() {
                                    isSelected = 3;
                                  });
                                },
                                icon: Icon(Icons.playlist_add_rounded),
                                label: Text('Create Date'),
                                style: ElevatedButton.styleFrom(
                                  primary: isSelected == 3
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                  elevation: 1,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  filterSetState(() {
                                    isSelected = 4;
                                  });
                                },
                                icon: Icon(Icons.topic_rounded),
                                label: Text('Project'),
                                style: ElevatedButton.styleFrom(
                                  primary: isSelected == 4
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                  elevation: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  Expanded(child: TaskStatusesFuture(querySnapshot: snapshot))
                ],
              ),
            ),
          );
        });
  }
}
