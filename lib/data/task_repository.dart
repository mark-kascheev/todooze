import 'package:todoooze/domain/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();

  Stream<List<Task>> subscribeToTasks();
}
