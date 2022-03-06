import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/domain/model/project.dart';
import 'package:todoooze/domain/repository/project_repository.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  final ProjectRepository repository;

  ProjectListBloc({required this.repository}) : super(ProjectListInitial()) {
    on<ProjectListStarted>(_fetchProjects);
  }

  void _fetchProjects(ProjectListStarted event, Emitter emit) async {
    emit(ProjectListLoadInProgress());
    try {
      final projects = await repository.getProjects();
      emit(ProjectListLoadSuccess(projects));
    } catch (error) {
      emit(ProjectListLoadFailure(error.toString()));
    }
  }
}

class ProjectListEvent {}

class ProjectListStarted extends ProjectListEvent {}

class ProjectListState {}

class ProjectListInitial extends ProjectListState {}

class ProjectListLoadInProgress extends ProjectListState {}

class ProjectListLoadSuccess extends ProjectListState {
  final List<Project> projects;

  ProjectListLoadSuccess(this.projects);
}

class ProjectListLoadFailure extends ProjectListState {
  final String message;

  ProjectListLoadFailure(this.message);
}
