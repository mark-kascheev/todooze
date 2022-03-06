import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoooze/data/model/task_dto.dart';
import 'package:todoooze/domain/api/api.dart';

const String tasksCollection = 'tasks';

class FirebaseTaskApi extends TaskApi {
  final instance = FirebaseFirestore.instance;

  @override
  Future<List<TaskDto>> getAllTasks() async {
    final snapshot = await instance.collection(tasksCollection).get();
    return snapshot.docs.map((doc) => TaskDto.fromApi(doc.id, doc.data())).toList();
  }

  @override
  Stream<List<TaskDto>> listenTasks() => instance
      .collection(tasksCollection)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
          .map((doc) => TaskDto.fromApi(doc.id, doc.data()))
          .toList());

  @override
  Future addNewTask(TaskDto taskDto) {
    return instance.collection(tasksCollection).add(taskDto.toJson());
  }

  @override
  Future updateTask(TaskDto taskDto) {
    return instance.doc('$tasksCollection/${taskDto.id}').update(taskDto.toJson());
  }
}
