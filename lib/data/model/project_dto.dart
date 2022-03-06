import 'package:intl/intl.dart';
import 'package:todoooze/data/model/task_dto.dart';
import 'package:todoooze/domain/model/project.dart';

class ProjectDto {
  final String id;
  final String title;
  final String type;
  final String startDate;
  final String endDate;
  final List<TaskDto> subtasks;

  ProjectDto._(
      {required this.id,
      required this.title,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.subtasks});

  ProjectDto.fromApi(this.id, Map<String, dynamic> map)
      : title = map['title'],
        type = map['type'],
        startDate = map['startDate'],
        endDate = map['endDate'],
        subtasks = (map['subtasks'] as List<Map<String, dynamic>>).toTaskDtoList(id);

  static ProjectDto fromModel(Project project) {
    final startDate = mapDateTimeToString(project.startDate);
    final endDate = mapDateTimeToString(project.endDate);
    final dtoSubtasks =
        project.subtasks.map((subtask) => TaskDto.fromModel(subtask)).toList();

    return ProjectDto._(
        id: project.id,
        title: project.title,
        type: project.type.name,
        startDate: startDate,
        endDate: endDate,
        subtasks: dtoSubtasks);
  }
}

extension ProjectDtoMapper on ProjectDto {
  Project toModel() => Project(
      id: id,
      title: title,
      type: mapStringToProjectType(type),
      startDate: mapStringToDateTime(startDate),
      endDate: mapStringToDateTime(endDate),
      subtasks: subtasks.map((dto) => dto.toModel()).toList());

  Map<String, dynamic> toJson() => {
        'title': title,
        'type': type,
        'startDate': startDate,
        'endDate': endDate,
        'subtasks': subtasks
      };
}

ProjectType mapStringToProjectType(String type) {
  switch (type.toLowerCase()) {
    case 'meeting':
      return ProjectType.meeting;
    case 'trip':
      return ProjectType.trip;
    case 'work':
      return ProjectType.work;
    default:
      return ProjectType.unknown;
  }
}

DateTime mapStringToDateTime(String date) {
  final formatter = DateFormat('dd-MM-y H:m:s');
  return formatter.parse(date);
}

String mapDateTimeToString(DateTime date) {
  final formatter = DateFormat('dd-MM-y H:m:s');
  return formatter.format(date);
}
