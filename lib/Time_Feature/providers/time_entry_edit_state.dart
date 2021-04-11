import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class TimeEntryEditState with ChangeNotifier {
  TimeEntry newEntry;
  bool isUpdate;
  DateTime date;

  TimeEntryEditState({this.isUpdate});

  void addEntry() {
    newEntry = TimeEntry();
  }

  void updateEntry(TimeEntry entry) {
    newEntry = entry;
  }

  void updateEntryName(String entryName) {
    newEntry.entryName = entryName;
    notifyListeners();
  }

  void updateEntryProject(Project projectName) {
    newEntry.project = projectName;
    notifyListeners();
  }

  // void updateEntryTask(Task task) {
  //   newEntry.task = task;
  //   notifyListeners();
  // }

  void updateDate(DateTime date) {
    newEntry.startTime = DateTime(date.year, date.month, date.day,
        newEntry.startTime.hour, newEntry.startTime.minute);
    newEntry.endTime = DateTime(date.year, date.month, date.day,
        newEntry.endTime.hour, newEntry.endTime.minute);
  }

  void updateStartEndTime(TimeRangeValue timeRangeValue) {
    newEntry.startTime = DateTime(
        newEntry.startTime.year,
        newEntry.startTime.month,
        newEntry.startTime.day,
        timeRangeValue.startTime.hour,
        timeRangeValue.startTime.minute);
    newEntry.endTime = DateTime(
        newEntry.endTime.year,
        newEntry.endTime.month,
        newEntry.endTime.day,
        timeRangeValue.endTime.hour,
        timeRangeValue.endTime.minute);
    notifyListeners();
  }

  // void updateEndTime(DateTime endDate) {
  //   newEntry.endTime = endDate;
  //   notifyListeners();
  // }

  void updateElapsedTime(int seconds) {
    newEntry.elapsedTime = seconds;
    notifyListeners();
  }
}
