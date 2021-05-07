import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';

class ProjectEditState extends ChangeNotifier {
  Project newProject;
  final Project oldProject;

  ProjectEditState({this.oldProject}) {
    if (oldProject != null) {
      newProject = oldProject.copyProject();
    } else {
      newProject = Project();
    }
  }

  void updateProject(Project project) {
    newProject = project;
  }

  void updateProjectName(String projectName) {
    newProject.projectName = projectName;
    notifyListeners();
  }

  void updateProjectColor(int projectColor) {
    newProject.projectColor = projectColor;
    notifyListeners();
  }

  void updateProjectClient(String projectClient) {
    newProject.projectClient = projectClient;
    notifyListeners();
  }
}
