import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoooze/data/model/project_dto.dart';
import 'package:todoooze/domain/api/project_api.dart';

const String projectsCollection = 'projects';
const String subtasksCollection = 'subtasks';

class FirebaseProjectApi extends ProjectApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProjectDto>> getProjects() async {
    final List<ProjectDto> dtoProjects = [];
    final snapshot = await _firestore.collection(projectsCollection).get();
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final subtaskSnapshot = await _firestore
          .collection('$projectsCollection/${doc.id}/$subtasksCollection')
          .get();
      final List<Map<String, dynamic>> subtaskMap = subtaskSnapshot.docs.map((doc) => doc.data()).toList();
      data[subtasksCollection] = subtaskMap;
      dtoProjects.add(ProjectDto.fromApi(doc.id, data));
    }
    return dtoProjects;
  }

  @override
  Future addNewProject(ProjectDto projectDto) async {
    return _firestore.collection(projectsCollection).add(projectDto.toJson());
  }

  @override
  Future updateProject(ProjectDto projectDto) async {
    return _firestore
        .collection(projectsCollection)
        .doc(projectDto.id)
        .update(projectDto.toJson());
  }
}
