import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/UI/widgets/cards/task.dart';
import 'package:barcloud/UI/widgets/headers/header.dart';
import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';

class HomeAgent extends StatefulWidget {
  const HomeAgent({Key? key}) : super(key: key);

  @override
  State<HomeAgent> createState() => _HomeAgentState();
}

class _HomeAgentState extends State<HomeAgent> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => authBloc,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "vos taches",
                style: styleSimplePlus.copyWith(color: colorAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(""),
            ),

            // options
          ])),
        ),
      ),
    );
  }
}
