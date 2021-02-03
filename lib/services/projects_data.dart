import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/models/projects.dart';


class AddProject extends StatelessWidget {
  final String projectName;
  final String projectColor;
  final int projectTime = 0;

  AddProject({this.projectName, this.projectColor});

  @override
  Widget build(BuildContext context) {
    CollectionReference project =
        FirebaseFirestore.instance.collection('projects');

    Future<void> addProject() {
      return project
          .add({
            'projectName': projectName,
            'projectColor': projectColor,
            'projectTime': projectTime
          })
          .then((value) => print('Project Added'))
          .catchError((error) => print('Failed to add project: $error'));
    }

    return FlatButton(onPressed: addProject, child: Text('Add Project'));
  }
}

class UpdateProject extends StatelessWidget {
  final String documentReference;
  final String projectName;
  final String projectColor;
  final int projectTime;

  UpdateProject(
      {this.documentReference,
      this.projectName,
      this.projectColor,
      this.projectTime});

  @override
  Widget build(BuildContext context) {
    CollectionReference project =
        FirebaseFirestore.instance.collection('projects');

    Future<void> updateProject() {
      return project
          .doc(documentReference)
          .update({
            'projectName': projectName,
            'projectColor': projectColor,
            'projectTime': projectTime
          })
          .then((value) => print('Project Updated'))
          .catchError((error) => print("Failed to update user: $error"));
    }

    return FlatButton(onPressed: updateProject, child: Text('Update Project'));
  }
}

class DeleteProject extends StatelessWidget {
  final String documentReference;

  DeleteProject({this.documentReference});

  @override
  Widget build(BuildContext context) {
    CollectionReference project =
        FirebaseFirestore.instance.collection('projects');

    Future<void> deleteProject() {
      return project
          .doc(documentReference)
          .delete()
          .then((value) => print('Project Deleted'))
          .catchError((error) => print('Failed to delete project: $error'));
    }

    // Future<void> deleteField() {
    //   return project
    //     .doc(documentReference)
    //     .delete()
    //     .then((value) => print('Project Deleted'))
    //     .catchError((error) => print('Failed to delete project: $error'));
    // }

    return FlatButton(onPressed: deleteProject, child: Text('Delete Project'));
  }
}

class ProjectStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference projects =
        FirebaseFirestore.instance.collection('projects');

    return StreamBuilder<QuerySnapshot>(
        stream: projects.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['projectName']),
                subtitle: new Text(document.data()['projectTime'].toString()),
              );
            }).toList(),
          );
        });
  }
}

// class ProjectData {
//   List<Projects> _projects = [];

//   UnmodifiableListView<Projects> get projects {
//     return UnmodifiableListView(_projects);
//   }

//   int get projectCount {
//     return _projects.length;
//   }

//   void addProject(String newProjectName, String newProjectColor) {
//     final newProject =
//         Projects(projectName: newProjectName, projectColor: newProjectColor);
//     _projects.add(newProject);
//   }

//   void updateProject(
//       Projects project, String updateProjectName, String updateProjectColor) {
//     project.projectName = updateProjectName;
//     project.projectColor = updateProjectColor;
//   }

//   void addTime(Projects project, int time) {
//     project.projectTime += time;
//   }

//   void deleteProject(Projects project) {
//     _projects.remove(project);
//   }
// }
