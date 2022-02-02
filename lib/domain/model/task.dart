class Task {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  Task({required this.id, required this.title, this.description = '', this.isDone = false});
}