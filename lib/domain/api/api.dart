import 'package:todoooze/data/model/task_dto.dart';

abstract class TaskApi {
  Future<List<TaskDto>> getAllTasks();
  Stream<List<TaskDto>> listenTasks();
}