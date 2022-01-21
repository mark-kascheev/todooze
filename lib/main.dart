import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/bloc/task_list_bloc.dart';
import 'package:todoooze/data/mock_task_repository.dart';
import 'package:todoooze/view/tasks/task_list.dart';

void main() {
  runApp(const TodooozeApp());
}

class TodooozeApp extends StatelessWidget {
  const TodooozeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => TaskListBloc(MockTaskRepository())..add(TaskListStarted()))
      ],
      child: const MaterialApp(
        home: SafeArea(
          child: Scaffold(
            body: TaskList(),
          ),
        ),
      ),
    );
  }
}

