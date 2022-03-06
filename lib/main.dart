import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todoooze/bloc/project_list_bloc.dart';
import 'package:todoooze/bloc/task_list_bloc.dart';
import 'package:todoooze/data/api/firebase_project_api.dart';
import 'package:todoooze/data/api/firebase_task_api.dart';
import 'package:todoooze/data/repository/project_data_repository.dart';
import 'package:todoooze/data/repository/task_data_repository.dart';
import 'package:todoooze/view/main_page.dart';
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
            create: (context) => TaskListBloc(TaskDataRepository(FirebaseTaskApi()))
              ..add(TaskListStarted())),
        BlocProvider(
            create: (context) => ProjectListBloc(repository: ProjectDataRepository(FirebaseProjectApi()))
              ..add(ProjectListStarted())),
      ],
      child: ChangeNotifierProvider<TodooozeTheme>(
        create: (_) => TodooozeTheme(),
        child: Consumer<TodooozeTheme>(builder: (context, theme, child) {
          return MaterialApp(
              initialRoute: '/',
              theme: theme.isLightTheme
                  ? TodooozeTheme.lightTheme()
                  : TodooozeTheme.darkTheme(),
              routes: {
                '/': (_) => const MainPage()
              });
        }),
      ),
    );
  }
}
