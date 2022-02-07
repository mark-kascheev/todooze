import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/domain/model/task.dart';
import 'package:todoooze/domain/repository/task_repository.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final TaskRepository taskRepository;

  CreateTaskBloc(this.taskRepository) : super(CreateTaskState(Task.empty())) {
    on<CreateTaskTitleEntered>(_updateTitle);
    on<CreateTaskDescriptionEntered>(_updateDescription);
    on<CreateTaskSaved>(_createNewTask);
  }

  void _updateTitle(CreateTaskTitleEntered event, Emitter emit){
    emit(CreateTaskState(state.task.copyWith(title: event.title)));
  }

  void _updateDescription(CreateTaskDescriptionEntered event, Emitter emit){
    emit(CreateTaskState(state.task.copyWith(description: event.description)));
  }

  void _createNewTask(CreateTaskSaved event, Emitter emit) async{
    try {
      await taskRepository.addNewTask(state.task);
    } catch(e) {

    }
  }
}

class CreateTaskEvent {}

class CreateTaskTitleEntered extends CreateTaskEvent {
  final String title;

  CreateTaskTitleEntered(this.title);
}

class CreateTaskDescriptionEntered extends CreateTaskEvent {
  final String description;

  CreateTaskDescriptionEntered(this.description);
}

class CreateTaskSaved extends CreateTaskEvent {}

class CreateTaskState {
  final Task task;

  CreateTaskState(this.task);
}

class CreateTaskSaveFailure extends CreateTaskState {
  final String message;

  CreateTaskSaveFailure({required Task task, required this.message}) : super(task);
}