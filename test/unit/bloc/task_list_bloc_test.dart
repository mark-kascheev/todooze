import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoooze/bloc/task_list_bloc.dart';
import 'package:todoooze/domain/model/task.dart';
import 'package:todoooze/domain/repository/task_repository.dart';

import 'create_task_bloc_test.mocks.dart';

void main() {
  late TaskListBloc tasksBloc;
  final TaskRepository repo = MockTaskRepository();

  setUp(() {
    tasksBloc = TaskListBloc(repo);
  });

  tearDown(() {
    tasksBloc.close();
  });

  group('Success tasks operations', () {
    test('Receive all tasks from subscription', () {
      final firstList = _createTestTasks(1);
      final secondList = _createTestTasks(2);

      when(repo.subscribeToTasks()).thenAnswer((_) => Stream.periodic(
              const Duration(milliseconds: 200), (i) => _createTestTasks(i))
          .skip(1)
          .take(2));

      tasksBloc.add(TaskListStarted());

      expect(
          tasksBloc.stream,
          emitsInOrder([
            TaskListLoadInProgress(),
            TaskListLoadSuccess(firstList),
            TaskListLoadSuccess(secondList)
          ]));
    });

    test('Update task and receive new updated list', () {
      final stream = StreamController<List<Task>>();
      final initialList = _createTestTasks(4);
      final resultList = _createTestTasks(4);
      const updatedTask = Task(
          id: '3',
          title: 'test_task_3',
          description: 'test_description_3',
          isDone: true);

      when(repo.subscribeToTasks()).thenAnswer((_) => stream.stream);
      when(repo.updateTask(updatedTask)).thenAnswer((_) async {
        resultList[2] = updatedTask;
        stream.sink.add(resultList);
        return Future.value();
      });

      stream.sink.add(initialList);

      tasksBloc.add(TaskListStarted());
      tasksBloc.add(TaskListItemChecked(task: initialList[2], isChecked: true));

      expect(
          tasksBloc.stream,
          emitsInOrder([
            TaskListLoadInProgress(),
            TaskListLoadSuccess(initialList),
            TaskListLoadSuccess(resultList)
          ]));
    });

    test('Delete task and receive new updated list', () {
      final stream = StreamController<List<Task>>();
      final initialList = _createTestTasks(4);
      final resultList = _createTestTasks(4);

      when(repo.subscribeToTasks()).thenAnswer((_) => stream.stream);
      when(repo.deleteTask(initialList[2])).thenAnswer((_) async {
        resultList.removeAt(2);
        stream.sink.add(resultList);
        return Future.value();
      });

      stream.sink.add(initialList);

      tasksBloc.add(TaskListStarted());
      tasksBloc.add(TaskListItemDeleted(task: initialList[2]));

      expect(
          tasksBloc.stream,
          emitsInOrder([
            TaskListLoadInProgress(),
            TaskListLoadSuccess(initialList),
            TaskListLoadSuccess(resultList)
          ]));
    });
  });

  group('Failure tasks operations', () {
    test('Cannot fetch tasks on start', () {
      when(repo.subscribeToTasks()).thenAnswer((_) => Stream.error(Exception()));

      tasksBloc.add(TaskListStarted());

      expect(tasksBloc.stream, emitsInOrder([TaskListLoadInProgress(), TaskListLoadFailure('Exception')]));
    });
  });
}

List<Task> _createTestTasks(int length) {
  final List<Task> tasks = [];
  for (int i = 1; i <= length; i++) {
    tasks.add(Task(
        id: '$i',
        title: 'test_task_$i',
        description: 'test_description_$i',
        isDone: false));
  }
  return tasks;
}
