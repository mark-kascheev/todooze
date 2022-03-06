import 'package:todoooze/data/model/project_dto.dart';

abstract class ProjectApi {
  Future<List<ProjectDto>> getProjects();
  Future addNewProject(ProjectDto projectDto);
  Future updateProject(ProjectDto projectDto);
}