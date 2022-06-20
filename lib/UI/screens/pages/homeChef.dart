import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/UI/screens/pages/tasksmanagerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/event/event_bloc.dart';
import '../../../logic/functions/navigation.dart';
import '../../widgets/cards/eventCard.dart';
import '../../widgets/cards/option.dart';
import '../../widgets/headers/header.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/ui/titleline.dart';
import '../views/scannerView.dart';
import 'Inv.dart';
import 'eventsscreen.dart';

class HomeChef extends StatefulWidget {
  const HomeChef({Key? key}) : super(key: key);

  @override
  State<HomeChef> createState() => _HomeChefState();
}

class _HomeChefState extends State<HomeChef> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(
          value: authBloc,
        ),
        BlocProvider<EventBloc>.value(
          value: eventBloc..add(EventEventFetch()),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          body: SingleChildScrollView(
              child: Column(
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return HeaderUser(user: authBloc.authRepository.user!);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventStateError) return Text("error");
                  if (state is EventStateLoaded)
                    return Column(
                      children: [
                        TitleLine(
                          title: "notifications",
                          todo: null,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return EventCard(event: eventBloc.events![index]);
                            },
                            itemCount: (eventBloc.events!.length < 3)
                                ? eventBloc.events!.length
                                : 3,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                          ),
                        ),
                      ],
                    );
                  if (state is EventStateEmpty) return SizedBox();
                  return Loading();
                },
              ),
              SizedBox(
                height: 8.0,
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
                          title: "gestion des taches",
                          todo: () {
                            openScreen(context, TasksManagerScreen());
                          }),
                      OptionCard(
                          image: "assets/print.png",
                          title: "accéder l'historique",
                          todo: () {
                            openScreen(context, EventsScreen());
                          }),
                    ],
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
