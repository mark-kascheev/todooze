import 'package:todoooze/domain/api/api.dart';
import 'package:todoooze/data/model/task_dto.dart';
import 'package:todoooze/domain/model/task.dart';
import 'package:todoooze/domain/repository/task_repository.dart';

class TaskDataRepository extends TaskRepository {
  TaskDataRepository(TaskApi api) : super(api);

  @override
  Future<List<Task>> getTasks() async {
    final dtoList = await api.getAllTasks();
    return dtoList.toTaskList();
  }

  @override
  Stream<List<Task>> subscribeToTasks() {
    return api
        .listenTasks()
        .map((dtoList) => dtoList.toTaskList());
  }
}