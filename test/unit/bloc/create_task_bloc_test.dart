import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoooze/bloc/create_task_bloc.dart';
import 'package:todoooze/domain/model/task.dart';
import 'package:todoooze/domain/repository/task_repository.dart';

import 'create_task_bloc_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late CreateTaskBloc createTaskBloc;
  late TaskRepository repo;

  setUp(() {
    repo = MockTaskRepository();
    createTaskBloc = CreateTaskBloc(repo);
  });

  tearDown(() {
    createTaskBloc.close();
  });

  group('Success emitting', () {
    const Task taskWithName =
        Task(id: '', title: 'test_title', description: '', isDone: false);
    const Task taskWithNameAndDescription = Task(
        id: '',
        title: 'test_title',
        description: 'test_description',
        isDone: false);

    test('Enter new title and emit state with this title', () async {
      createTaskBloc.add(CreateTaskTitleEntered('test_title'));

      expect(
          createTaskBloc.stream,
          emitsInOrder([
            const CreateTaskState(taskWithName),
          ]));
    });

    test('Enter new description and emit state with this description',
        () async {
      const taskWithDescription =
          Task(id: '', title: '', description: 'test_description');
      createTaskBloc.add(CreateTaskDescriptionEntered('test_description'));

      expect(createTaskBloc.stream,
          emitsInOrder([const CreateTaskState(taskWithDescription)]));
    });

    test('Success task creation', () async {
      when(repo.addNewTask(taskWithNameAndDescription))
          .thenAnswer((task) => Future.value());

      createTaskBloc.add(CreateTaskTitleEntered('test_title'));
      createTaskBloc.add(CreateTaskDescriptionEntered('test_description'));
      createTaskBloc.add(CreateTaskSaved());

      expect(
          createTaskBloc.stream,
          emitsInOrder([
            const CreateTaskState(taskWithName),
            const CreateTaskState(taskWithNameAndDescription),
            const CreateTaskSaveSuccess(taskWithNameAndDescription)
          ]));
    });
  });

  group('Failure emitting', () {
    test('Repo throws exception and bloc handle it', () {
      const task = Task(id: '', title: 'test_title');

      when(repo.addNewTask(task))
          .thenThrow((task) => Exception('Something went wrong'));

      createTaskBloc.add(CreateTaskTitleEntered('test_title'));
      createTaskBloc.add(CreateTaskSaved());

      expect(
          createTaskBloc.stream,
          emitsInOrder([
            const CreateTaskState(task),
            const CreateTaskSaveFailure(task: task, message: 'Something went wrong')
          ]));
    });
  });
}
