import 'package:barcloud/UI/screens/pages/login.dart';
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

            // options
          ])),
        ),
      ),
    );
  }
}
