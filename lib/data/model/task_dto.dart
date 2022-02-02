import 'package:todoooze/domain/model/task.dart';

class TaskDto {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  TaskDto.fromApi(this.id, Map<String, dynamic> map)
      : title = map['title'],
        description = map['description'],
        isDone = map['isDone'];
}

extension TaskMapper on TaskDto {
  Task toModel() =>
      Task(id: id, title: title, description: description, isDone: isDone);
}

extension TaskListMapper on List<TaskDto> {
  List<Task> toTaskList() => map((item) => item.toModel()).toList();
}
