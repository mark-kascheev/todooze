import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/domain/repository/task_repository.dart';
import 'package:todoooze/domain/model/task.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskRepository taskRepo;

  TaskListBloc(this.taskRepo) : super(TaskListInitial()) {
    on<TaskListStarted>(_listenTasks);
    on<TaskListItemChecked>(_updateListItem);
  }

  void _listenTasks(TaskListStarted event, Emitter emit) async {
    emit(TaskListLoadInProgress());
    await emit.onEach<List<Task>>(taskRepo.subscribeToTasks(),
        onData: (tasks) => emit(TaskListLoadSuccess(tasks)),
        onError: (e, stackTrace) => emit(TaskListLoadFailure(e.toString())));
  }

  void _updateListItem(TaskListItemChecked event, Emitter emit) async {
    final updatedTask = event.task.copyWith(isDone: event.isChecked);
    await taskRepo.updateTask(updatedTask);
  }
}

abstract class TaskListEvent {}

class TaskListStarted extends TaskListEvent {}

class TaskListItemChecked extends TaskListEvent {
  final Task task;
  final bool isChecked;

  TaskListItemChecked({required this.task, required this.isChecked});
}

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
