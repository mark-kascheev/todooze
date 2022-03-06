import 'package:todoooze/domain/api/project_api.dart';
import 'package:todoooze/domain/model/project.dart';

abstract class ProjectRepository {
  final ProjectApi api;

  ProjectRepository(this.api);

  Future<List<Project>> getProjects();

  Future addNewProject(Project project);

  Future updateProject(Project project);
}