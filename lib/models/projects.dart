import 'package:flutter/material.dart';
import 'package:productivity_app/models/colors.dart';
import 'package:productivity_app/models/tasks.dart';

class Projects {
  String projectID;
  String projectName;
  // TODO double check what variable type this needs to be
  ProjectColors projectColor;
  int projectTime = 0;
  List<Tasks> taskList = [];

  Projects({this.projectID, this.projectName, this.projectColor});
}
