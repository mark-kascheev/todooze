import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/bloc/task_list_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(builder: (context, state) {
      if (state is TaskListLoadInProgress) {
        return const CircularProgressIndicator();
      }
      if (state is TaskListLoadFailure) {
        return Text('Error ${state.message}');
      }
      if (state is TaskListLoadSuccess) {
        final taskList = state.tasks;
        return ListView.separated(
            itemCount: taskList.length,
            itemBuilder: (context, index) => _TaskItem(
                title: taskList[index].title,
                isChecked: taskList[index].isDone),
            separatorBuilder: (context, index) => const SizedBox(height: 10));
      }
      return const SizedBox();
    });
  }
}

class _TaskItem extends StatelessWidget {
  final String title;
  final bool isChecked;

  const _TaskItem({Key? key, required this.title, required this.isChecked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {},
        shape: const CircleBorder(),
      ),
      title: Text(title,
          maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.height),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      tileColor: Colors.grey,
    );
  }
}
