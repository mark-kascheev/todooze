import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoooze/bloc/project_list_bloc.dart';
import 'package:todoooze/domain/model/project.dart';
import 'package:todoooze/view/projects/circular_project_progress.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListBloc, ProjectListState>(
        builder: (context, state) {
      if (state is ProjectListLoadInProgress) {
        return const CircularProgressIndicator();
      }
      if (state is ProjectListLoadSuccess) {
        return _ProjectsHorizontalView(projects: state.projects);
      }
      if (state is ProjectListLoadFailure) {
        return Text(state.message);
      }
      return const SizedBox();
    });
  }
}

class _ProjectsHorizontalView extends StatelessWidget {
  final List<Project> projects;

  const _ProjectsHorizontalView({Key? key, required this.projects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
          itemCount: projects.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => _ProjectCard(projects[index]),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox()),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard(this.project, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProjectProgress(projectId: project.id, radius: 15),
          const SizedBox(height: 30),
          Text(project.type.name.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 11),
              maxLines: 1),
          const SizedBox(height: 15),
          Text(project.title,
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 15)),
          const Spacer(),
          Chip(
              label: Text("TODAY, 4 P.M"),
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withAlpha(30),
              labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 12))
        ],
      ),
    );
  }
}
