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
            itemBuilder: (context, index) {
             final task = taskList[index];
             return _TaskItem(
                 key: ValueKey(task.id),
                 title: task.title,
                 isChecked: task.isDone);
            },
          separatorBuilder: (context, index) => const SizedBox(height: 10));
      }
      return const SizedBox();
    });
  }
}

class _TaskItem extends StatefulWidget {
  final String title;
  final bool isChecked;

  const _TaskItem({Key? key, required this.title, required this.isChecked})
      : super(key: key);

  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 10),
      leading: Checkbox(
        activeColor: Theme.of(context).colorScheme.onBackground,
        checkColor: Theme.of(context).colorScheme.primary,
        value: _isChecked,
        onChanged: (bool? value) {
          setState(() {
            _isChecked = value ?? false;
          });
        },
        shape: const CircleBorder(),
      ),
      title: Text(widget.title,
          style: _isChecked
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Theme.of(context).colorScheme.onBackground)
              : null,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis),
      trailing: Image.asset('assets/icons/change_order_item.png',
          width: 20, height: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      tileColor: Theme.of(context).colorScheme.primary,
    );
  }
}
