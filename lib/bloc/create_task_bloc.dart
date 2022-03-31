import 'package:equatable/equatable.dart';
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
    final Task task = state.task;
    try {
      if(task.title.isNotEmpty) {
        await taskRepository.addNewTask(task);
        emit(CreateTaskSaveSuccess(task));
      }
    } catch(e) {
      emit(CreateTaskSaveFailure(task: task, message: 'Error'));
    }
  }
}

abstract class CreateTaskEvent extends Equatable{}

class CreateTaskTitleEntered extends CreateTaskEvent {
  final String title;

  CreateTaskTitleEntered(this.title);

  @override
  List<Object?> get props => [title];
}

class CreateTaskDescriptionEntered extends CreateTaskEvent {
  final String description;

  CreateTaskDescriptionEntered(this.description);

  @override
  List<Object?> get props => [description];
}

class CreateTaskSaved extends CreateTaskEvent {
  @override
  List<Object?> get props => [];
}

class CreateTaskState extends Equatable{
  final Task task;

  const CreateTaskState(this.task);

  @override
  List<Object?> get props => [task];
}

class CreateTaskSaveSuccess extends CreateTaskState {

  const CreateTaskSaveSuccess(Task task) : super(task);
}

class CreateTaskSaveFailure extends CreateTaskState {
  final String message;

  const CreateTaskSaveFailure({required Task task, required this.message}) : super(task);
}