import 'package:flutter/material.dart';
import 'package:todoooze/view/common/appbar.dart';
import 'package:todoooze/view/projects/project_list.dart';
import 'package:todoooze/view/tasks/create_task_dialog_content.dart';
import 'package:todoooze/view/tasks/task_list.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: const [
            SizedBox(height: 15),
            _PageSection(title: 'Projects', child: ProjectList()),
            SizedBox(height: 15),
            _PageSection(title: 'Tasks', child: TaskList()),
            SizedBox(height: 15),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
    );
  }
}

class _PageSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _PageSection({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const SizedBox(height: 15),
        Flexible(child: child)
      ],
    );
  }
}
