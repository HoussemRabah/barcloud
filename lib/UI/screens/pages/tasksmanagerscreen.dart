import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/task/task_bloc.dart';
import '../../../modules/class.dart';
import '../../widgets/cards/task.dart';
import '../../widgets/headers/headerTasks.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/ui/titleline.dart';

class TasksManagerScreen extends StatefulWidget {
  const TasksManagerScreen({Key? key}) : super(key: key);

  @override
  State<TasksManagerScreen> createState() => _TasksManagerScreenState();
}

class _TasksManagerScreenState extends State<TasksManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>.value(
          value: taskBloc..add(TaskEventFetch()),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorPrime,
            elevation: 0.0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: colorPrime,
          ),
          backgroundColor: colorBack,
          body: SingleChildScrollView(
            child: Column(
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
                        TitleLine(title: "taches"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return TaskCard(
                                  task: taskBloc.tasks!
                                      .where((element) =>
                                          (element.process != TaskProcess.end))
                                      .toList()[index]);
                            },
                            itemCount: taskBloc.tasks!
                                .where((element) =>
                                    (element.process != TaskProcess.end))
                                .length,
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
                            itemCount: taskBloc.tasks!
                                .where((element) =>
                                    (element.process == TaskProcess.end))
                                .length,
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
      ),
    );
  }
}
