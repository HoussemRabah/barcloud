import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/UI/widgets/ui/titleline.dart';
import 'package:barcloud/UI/widgets/users/userlabel.dart';
import 'package:barcloud/core/constants.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/sys.dart';
import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/task/task_bloc.dart';

class TaskScreen extends StatefulWidget {
  final Task task;
  const TaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
          floatingActionButton: Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(borderRadius: radius, color: colorPrime),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Démarrer la tache",
                style: styleSimplePlus.copyWith(color: colorMain),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: colorPrime,
            elevation: 0.0,
          ),
          backgroundColor: colorBack,
          body: SingleChildScrollView(
              child: Column(
            children: [
              TitleLine(title: "de la part de"),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskStateLoaded)
                    return FutureBuilder(
                      future: widget.task.getCreator(),
                      builder: (BuildContext context,
                          AsyncSnapshot<TheUser?> snapshot) {
                        if (snapshot.hasData) if (snapshot.data != null)
                          return UserLabel(
                              username: snapshot.data!.getFullName(),
                              image: snapshot.data!.getImage(),
                              sub: snapshot.data!.sub);
                        return Loading();
                      },
                    );
                  return Loading();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.task.title,
                  style: styleSimplePlus.copyWith(color: colorPrime),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "deadline : ${timeToString(widget.task.deadline)}",
                  style: styleSimple.copyWith(color: colorAccent),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.task.disc,
                  style: styleSimple,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
