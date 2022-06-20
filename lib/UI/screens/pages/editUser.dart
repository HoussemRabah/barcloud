import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/UI/widgets/ui/optionHor.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/user/user_bloc.dart';
import '../../widgets/headers/header.dart';

class EditUser extends StatefulWidget {
  final TheUser user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>.value(
          value: userBloc,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          body: SingleChildScrollView(
              child: Column(
            children: [
              HeaderUser(user: widget.user),
              SizedBox(
                height: 8.0,
              ),
              OptionHor(
                  icon: Icons.delete,
                  title: "supprimer définitivement le compte",
                  todo: () {}),
              OptionHor(
                  icon: Icons.delete,
                  title: "blockage temporaire du compte",
                  todo: () {}),
              OptionHor(
                  icon: Icons.delete,
                  title: "modifier les informations du compte",
                  todo: () {}),
              OptionHor(
                  icon: Icons.delete,
                  title: "modifier les autorisations",
                  todo: () {}),
            ],
          )),
        ),
      ),
    );
    ;
  }
}
