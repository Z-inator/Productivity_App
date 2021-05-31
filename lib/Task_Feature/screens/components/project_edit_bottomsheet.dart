import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:productivity_app/Shared/widgets/color_selector.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:provider/provider.dart';

class ProjectEditBottomSheet extends StatelessWidget {
  final bool isUpdate;
  final Project project;
  ProjectEditBottomSheet({Key key, this.isUpdate, this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectEditState(oldProject: project),
      builder: (context, child) {
        final DatabaseService databaseService =
            Provider.of<DatabaseService>(context);
        final projectEditState = Provider.of<ProjectEditState>(context);
        return Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: projectEditState.newProject.projectName.isEmpty
                        ? 'Project Name'
                        : projectEditState.newProject.projectName),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  projectEditState.updateProjectName(newText);
                },
              ),
              ColorSelector(
                matchColor: isUpdate
                ? DynamicColorTheme.of(context).isDark
                  ? AppColors.colorList[projectEditState.newProject.projectColor].shade200.value
                  : AppColors.colorList[projectEditState.newProject.projectColor].value
                : projectEditState.newProject.projectColor,
                saveColor: projectEditState.updateProjectColor,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: projectEditState.newProject.projectClient.isEmpty
                        ? 'Add Client'
                        : projectEditState.newProject.projectClient),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  projectEditState.updateProjectClient(newText);
                },
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.check_circle_outline_rounded),
                      label: Text(isUpdate ? 'Update' : 'Add'),
                      onPressed: () {
                        isUpdate
                            ? databaseService.updateItem(
                                type: 'projects',
                                itemID: project.id,
                                updateData: projectEditState.newProject.toFirestore())
                            : databaseService.addItem(
                                type: 'projects',
                                addData: projectEditState.newProject.toFirestore());
                        Navigator.pop(context);
                      }))
            ],
          ),
        );
      },
    );
  }
}
