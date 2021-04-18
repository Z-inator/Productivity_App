import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/status_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class StatusExpansionTile extends StatelessWidget {
  final Status status;
  const StatusExpansionTile({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatusService statusService = Provider.of<StatusService>(context);
    final TaskService taskService = Provider.of<TaskService>(context);
    List<Task> tasks =
        taskService.getTasksByStatus(Provider.of<List<Task>>(context), status);
    int taskCount = statusService.getTaskCount(tasks, status);
    return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: key,
          leading: Icon(Icons.circle, color: Color(status.statusColor)),
          title: Text(
            status.statusName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      icon: Icon(Icons.edit_rounded),
                      tooltip: 'Edit Status',
                      onPressed: () => EditBottomSheet().buildEditBottomSheet(
                          context: context,
                          bottomSheet: StatusEditBottomSheet(
                              isUpdate: true, status: status))),
                  IconButton(
                    icon: Icon(Icons.delete_rounded),
                    tooltip: 'Delete Status',
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Status: ${status.statusName}?'),
                            content: ListTile(
                              title: Text(
                                  'This will permanently delete this status.\nIt will not effect related tasks.'),
                            ),
                            actions: [
                              OutlinedButton.icon(
                                icon: Icon(Icons.cancel_rounded),
                                label: Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              ElevatedButton.icon(
                                  icon:
                                      Icon(Icons.check_circle_outline_rounded),
                                  label: Text('Delete'),
                                  onPressed: () {
                                    statusService.deleteStatus(
                                        statusID: status.statusID);
                                    Navigator.pop(context);
                                  })
                            ],
                          );
                        }),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_rounded),
                    tooltip: 'Add Task',
                    onPressed: () => EditBottomSheet().buildEditBottomSheet(
                        context: context,
                        bottomSheet: TaskEditBottomSheet(
                            isUpdate: false, status: status)),
                  )
                ],
              ),
              children: [
                ListTile(
                  title: Text('Tasks: $taskCount',
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                ListTile(
                  title: Text('Description:',
                      style: Theme.of(context).textTheme.subtitle1),
                  subtitle: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel.',
                      overflow: TextOverflow.fade,
                      maxLines: 3),
                )
              ],
            )
          ],
        ));
  }
}
