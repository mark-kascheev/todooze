import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todoooze/bloc/task_list_bloc.dart';
import 'package:todoooze/data/api/firebase_api.dart';
import 'package:todoooze/data/repository/task_data_repository.dart';
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
              ..add(TaskListStarted()))
      ],
      child: ChangeNotifierProvider<TodooozeTheme>(
        create: (_) => TodooozeTheme(),
        child: Consumer<TodooozeTheme>(builder: (context, theme, child) {
          return MaterialApp(
            theme: theme.isLightTheme
                ? TodooozeTheme.lightTheme()
                : TodooozeTheme.darkTheme(),
            home: LayoutBuilder(
              builder: (context, _) {
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
                        onPressed: () {},
                        child: const Icon(Icons.add),
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryVariant),
                  ),
                );
              }
            ),
          );
        }),
      ),
    );
  }
}
