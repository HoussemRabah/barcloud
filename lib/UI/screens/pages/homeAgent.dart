import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/UI/widgets/cards/task.dart';
import 'package:barcloud/UI/widgets/headers/header.dart';
import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/task/task_bloc.dart';
import '../../widgets/loading/loading.dart';

class HomeAgent extends StatefulWidget {
  const HomeAgent({Key? key}) : super(key: key);

  @override
  State<HomeAgent> createState() => _HomeAgentState();
}

class _HomeAgentState extends State<HomeAgent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(
          value: authBloc,
        ),
        BlocProvider<TaskBloc>(
          create: (context) => taskBloc..add(TaskEventInit()),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          body: SingleChildScrollView(
              child: Column(children: [
            // header
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthStateDone)
                  return HeaderUser(user: authBloc.authRepository.user!);
                return Loading();
              },
            ),
            // tasks
            SizedBox(
              height: 8.0,
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskStateError) return Text("error");
                if (state is TaskStateLoaded)
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "vos taches",
                          style: styleSimplePlus.copyWith(color: colorAccent),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return TaskCard(task: taskBloc.tasks![index]);
                          },
                          itemCount: taskBloc.tasks!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  );
                if (state is TaskStateEmpty) return Text("empry");
                return Loading();
              },
            ),

            // options
          ])),
        ),
      ),
    );
  }
}
