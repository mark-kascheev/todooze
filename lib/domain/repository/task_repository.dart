import 'package:todoooze/domain/api/api.dart';
import 'package:todoooze/domain/model/task.dart';

abstract class TaskRepository {
  final TaskApi api;

  TaskRepository(this.api);

  Future<List<Task>> getTasks();

  Stream<List<Task>> subscribeToTasks();

  Future addNewTask(Task task);
}
