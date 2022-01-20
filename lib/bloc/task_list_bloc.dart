import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/data/task_repository.dart';
import 'package:todoooze/domain/task.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskRepository taskRepo;

  TaskListBloc(this.taskRepo) : super(TaskListInitial()) {
    on<TaskListStarted>((event, emit) async {
      emit(TaskListLoadInProgress());
      try {
        final tasks = await taskRepo.getTasks();
        emit(TaskListLoadSuccess(tasks));
      } catch (e) {
        emit(TaskListLoadFailure(e.toString()));
      }
    });
  }
}

abstract class TaskListEvent {}

class TaskListStarted extends TaskListEvent {}

abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoadInProgress extends TaskListState {}

class TaskListLoadSuccess extends TaskListState {
  final List<Task> tasks;

  TaskListLoadSuccess(this.tasks);
}

class TaskListLoadFailure extends TaskListState {
  final String message;

  TaskListLoadFailure(this.message);
}
