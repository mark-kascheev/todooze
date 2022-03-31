import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String id;
  final String title;
  final String description;
  final bool isDone;

  const Task(
      {required this.id,
      required this.title,
      this.description = '',
      this.isDone = false});

  const Task.empty()
      : id = '',
        title = '',
        description = '',
        isDone = false;

  @override
  List<Object?> get props => [id, title, description, isDone];
}

extension TaskUtils on Task {
  Task copyWith(
      {String? id, String? title, String? description, bool? isDone}) {
    return Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone);
  }
}
