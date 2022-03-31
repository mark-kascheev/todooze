import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/domain/repository/task_repository.dart';
import 'package:todoooze/domain/model/task.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final TaskRepository taskRepo;

  TaskListBloc(this.taskRepo) : super(TaskListInitial()) {
    on<TaskListStarted>(_listenTasks);
    on<TaskListItemChecked>(_updateListItem);
    on<TaskListItemDeleted>(_deleteListItem);
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

  void _deleteListItem(TaskListItemDeleted event, Emitter emit) async {
    await taskRepo.deleteTask(event.task);
  }
}

abstract class TaskListEvent extends Equatable{}

class TaskListStarted extends TaskListEvent {
  @override
  List<Object?> get props => [];
}

class TaskListItemChecked extends TaskListEvent {
  final Task task;
  final bool isChecked;

  TaskListItemChecked({required this.task, required this.isChecked});

  @override
  List<Object?> get props => [task, isChecked];
}

class TaskListItemDeleted extends TaskListEvent {
  final Task task;

  TaskListItemDeleted({required this.task});

  @override
  List<Object?> get props => [task];
}

abstract class TaskListState extends Equatable {}

class TaskListInitial extends TaskListState {
  @override
  List<Object?> get props => [];
}

class TaskListLoadInProgress extends TaskListState {
  @override
  List<Object?> get props => [];
}

class TaskListLoadSuccess extends TaskListState {
  final List<Task> tasks;

  TaskListLoadSuccess(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskListLoadFailure extends TaskListState {
  final String message;

  TaskListLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
