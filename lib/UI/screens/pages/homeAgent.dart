import 'package:barcloud/UI/screens/pages/addItem.dart';
import 'package:barcloud/UI/screens/pages/itemscreen.dart';
import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/UI/screens/pages/tasks.dart';
import 'package:barcloud/UI/screens/views/scannerView.dart';
import 'package:barcloud/UI/widgets/cards/option.dart';
import 'package:barcloud/UI/widgets/cards/task.dart';
import 'package:barcloud/UI/widgets/headers/header.dart';
import 'package:barcloud/UI/widgets/ui/titleline.dart';
import 'package:barcloud/UI/screens/pages/Inv.dart';

import 'package:barcloud/core/constants.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:barcloud/modules/class.dart';
import 'package:barcloud/repository/scanner_repo.dart';
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
        BlocProvider<TaskBloc>.value(
          value: taskBloc..add(TaskEventInit()),
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
                return HeaderUser(user: authBloc.authRepository.user!);
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
                      TitleLine(
                        title: "vos taches",
                        todo: () {
                          openScreen(context, TasksScreen());
                        },
                      ),
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
                    ],
                  );
                if (state is TaskStateEmpty) return SizedBox();
                return Loading();
              },
            ),

            // options
            Column(
              children: [
                TitleLine(title: "options"),
                Wrap(
                  runSpacing: 8.0,
                  spacing: 8.0,
                  children: [
                    OptionCard(
                        image: "assets/checklist.png",
                        title: "inventaire",
                        todo: () {
                          openScreen(context, InvScreen());
                        }),
                    OptionCard(
                        image: "assets/scanner.png",
                        title: "scanner le code",
                        todo: () {}),
                    OptionCard(
                        image: "assets/print.png",
                        title: "imprimer code",
                        todo: () {
                          openScreen(context, ScannerView());
                        }),
                    OptionCard(
                        image: "assets/additem.svg",
                        title: "ajouter un item",
                        todo: () {
                          openScreen(context, AddItem());
                        }),
                  ],
                )
              ],
            )
          ])),
        ),
      ),
    );
  }
}
