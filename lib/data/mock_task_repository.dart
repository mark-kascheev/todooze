import 'package:todoooze/data/task_repository.dart';
import 'package:todoooze/domain/task.dart';

class MockTaskRepository extends TaskRepository {
  @override
  Future<List<Task>> getTasks() async {
    final mockTasks = <Task>[];
    for (int i = 0; i <= 10; i++) {
      mockTasks
          .add(Task(title: 'Some description for testing #$i', isDone: true));
    }
    return Future.value(mockTasks);
  }

  @override
  Stream<List<Task>> subscribeToTasks() {
    // TODO: implement subscribeToTasks
    throw UnimplementedError();
  }
}
