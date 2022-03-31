import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/bloc/create_task_bloc.dart';
import 'package:todoooze/data/api/firebase_task_api.dart';
import 'package:todoooze/data/repository/task_data_repository.dart';

class CreateTaskDialogContent extends StatefulWidget {
  const CreateTaskDialogContent({Key? key}) : super(key: key);

  @override
  State<CreateTaskDialogContent> createState() =>
      _CreateTaskDialogContentState();
}

class _CreateTaskDialogContentState extends State<CreateTaskDialogContent> {
  Widget description = const SizedBox(height: 25);
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          CreateTaskBloc(TaskDataRepository(FirebaseTaskApi())),
      child: BlocListener<CreateTaskBloc, CreateTaskState>(
        listener: (context, state) {
          if(state is CreateTaskSaveSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          margin: MediaQuery.of(context).viewInsets,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            child: BlocBuilder<CreateTaskBloc, CreateTaskState>(
                builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _TitleField(onKeyboardAction: () => _saveTask(context)),
                  description,
                  Row(
                    children: [
                      _DialogIconButton(
                          onTap: _openDescriptionField,
                          iconPath: 'assets/icons/description.png'),
                      const SizedBox(width: 30),
                      const _DialogIconButton(
                          iconPath: 'assets/icons/calendar.png'),
                      const Spacer(),
                      _DialogIconButton(
                          onTap: state.task.title.isEmpty
                              ? null
                              : () => _saveTask(context),
                          iconPath: 'assets/icons/save.png',
                          color: Theme.of(context).colorScheme.secondaryContainer),
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void _openDescriptionField() {
    setState(() {
      description = Column(
        children: [
          const SizedBox(height: 15),
          _DescriptionField(focusNode: focusNode),
          const SizedBox(height: 15)
        ],
      );
      focusNode.requestFocus();
    });
  }

  void _saveTask(BuildContext context) {
    BlocProvider.of<CreateTaskBloc>(context).add(CreateTaskSaved());
    // Navigator.of(context).pop();
  }
}

class _TitleField extends StatelessWidget {
  final Function? onKeyboardAction;

  const _TitleField({Key? key, this.onKeyboardAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onChanged: (newTitle) => BlocProvider.of<CreateTaskBloc>(context)
          .add(CreateTaskTitleEntered(newTitle)),
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => onKeyboardAction?.call(),
      cursorColor: Theme.of(context).colorScheme.primaryContainer,
      decoration: const InputDecoration(
          border: InputBorder.none, hintText: 'What to do?', isCollapsed: true),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode? focusNode;

  _DescriptionField({Key? key, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: focusNode,
      onChanged: (newDescription) => BlocProvider.of<CreateTaskBloc>(context)
          .add(CreateTaskDescriptionEntered(newDescription)),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: Theme.of(context).colorScheme.primaryContainer,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Add description',
          isCollapsed: true),
    );
  }
}

class _DialogIconButton extends StatelessWidget {
  final String iconPath;
  final Color? color;
  final double iconSize = 24;
  final Function()? onTap;

  const _DialogIconButton(
      {Key? key, required this.iconPath, this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).colorScheme.primaryContainer;
    return InkWell(
      onTap: onTap,
      child: Image.asset(iconPath,
          color: onTap != null
              ? _color
              : Theme.of(context).colorScheme.onBackground,
          width: iconSize,
          height: iconSize),
    );
  }
}
