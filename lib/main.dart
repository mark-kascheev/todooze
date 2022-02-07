import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todoooze/bloc/create_task_bloc.dart';
import 'package:todoooze/bloc/task_list_bloc.dart';
import 'package:todoooze/data/api/firebase_api.dart';
import 'package:todoooze/data/repository/task_data_repository.dart';
import 'package:todoooze/view/tasks/create_task_dialog_content.dart';
import 'package:todoooze/view/tasks/task_list.dart';
import 'package:todoooze/view/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TodooozeApp());
}

class TodooozeApp extends StatelessWidget {
  const TodooozeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TaskListBloc(TaskDataRepository(FirebaseApi()))
              ..add(TaskListStarted())),
      ],
      child: ChangeNotifierProvider<TodooozeTheme>(
        create: (_) => TodooozeTheme(),
        child: Consumer<TodooozeTheme>(builder: (context, theme, child) {
          return MaterialApp(
              theme: theme.isLightTheme
                  ? TodooozeTheme.lightTheme()
                  : TodooozeTheme.darkTheme(),
              home: const MainPage());
        }),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<TodooozeTheme>().switchMode();
                },
                child: Text('change mode')),
            Flexible(child: TaskList()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierLabel: 'task_creation',
              barrierDismissible: true,
              pageBuilder: (context, anim1, anim2) => const Align(
                  alignment: Alignment.bottomCenter,
                  child: CreateTaskDialogContent()),
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position:
                      Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                          .animate(anim1),
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
