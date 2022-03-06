import 'package:todoooze/data/model/project_dto.dart';
import 'package:todoooze/domain/api/project_api.dart';
import 'package:todoooze/domain/model/project.dart';
import 'package:todoooze/domain/repository/project_repository.dart';

class ProjectDataRepository extends ProjectRepository {
  ProjectDataRepository(ProjectApi api) : super(api);

  @override
  Future<List<Project>> getProjects() async {
    final dtoProjects = await api.getProjects();
    return dtoProjects.map((dto) => dto.toModel()).toList();
  }

  @override
  Future addNewProject(Project project) =>
      api.addNewProject(ProjectDto.fromModel(project));

  @override
  Future updateProject(Project project) =>
      api.updateProject(ProjectDto.fromModel(project));
}
