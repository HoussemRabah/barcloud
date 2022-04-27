import 'package:barcloud/UI/widgets/ui/titleline.dart';
import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/task/task_bloc.dart';
import '../../../modules/class.dart';
import '../../widgets/cards/task.dart';
import '../../widgets/headers/headerTasks.dart';
import '../../widgets/loading/loading.dart';
import 'login.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(
          value: authBloc,
        ),
        BlocProvider<TaskBloc>.value(
          value: taskBloc,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorPrime,
            elevation: 0.0,
          ),
          backgroundColor: colorBack,
          body: Column(
            children: [
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskStateLoading) return Loading();
                  return HeaderTasks(
                    taskFinish: taskBloc.tasksFinished ?? 0,
                    taskWaiting: taskBloc.tasksWaiting ?? 0,
                  );
                },
              ),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskStateLoading) return Loading();
                  if (state is TaskStateError) return Loading();
                  if (state is TaskStateEmpty) return Text("error");
                  return Column(
                    children: [
                      TitleLine(title: "vos taches"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return TaskCard(task: taskBloc.tasks!.where((element) => (element.process != TaskProcess.end)).toList()[index]);
                          },
                          itemCount: taskBloc.tasks!.where((element) => (element.process != TaskProcess.end)).length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      ),
                      TitleLine(title: "tâches accomplies"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return TaskCard(task: taskBloc.tasks![index]);
                          },
                          itemCount: taskBloc.tasks!.where((element) => (element.process == TaskProcess.end)).length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
