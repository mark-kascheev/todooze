import 'package:todoooze/domain/model/task.dart';

enum ProjectType {
  meeting,
  trip,
  work,
  unknown
}

class Project {
  final String id;
  final String title;
  final ProjectType type;
  final List<Task> subtasks;
  final DateTime startDate;
  final DateTime endDate;

  Project({required this.id, required this.title, required this.subtasks, required this.type, required this.startDate, required this.endDate});
}