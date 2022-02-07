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

  TaskDto.fromModel(Task task)
      : id = task.id,
        title = task.title,
        description = task.description,
        isDone = task.isDone;
}

extension TaskDtoMapper on TaskDto {
  Task toModel() =>
      Task(id: id, title: title, description: description, isDone: isDone);

  Map<String, dynamic> toJson() =>
      {'title': title, 'description': description, 'isDone': isDone};
}

extension TaskListMapper on List<TaskDto> {
  List<Task> toTaskList() => map((item) => item.toModel()).toList();
}
