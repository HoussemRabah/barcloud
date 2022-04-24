import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/task/task_bloc.dart';
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
        BlocProvider<TaskBloc>(
          create: (context) => taskBloc,
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
            ],
          ),
        ),
      ),
    );
  }
}
