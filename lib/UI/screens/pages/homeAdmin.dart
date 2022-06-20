import 'package:barcloud/UI/screens/pages/editUser.dart';
import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/core/constants.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/user/user_bloc.dart';
import '../../../modules/class.dart';
import '../../widgets/headers/header.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/users/userlabel.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(
          value: authBloc,
        ),
        BlocProvider<UserBloc>.value(
          value: userBloc..add(UserEventFetch()),
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
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserStateLoaded)
                    return Column(
                      children: [
                        for (TheUser user in userBloc.users!)
                          GestureDetector(
                              onTap: () {
                                openScreen(context, EditUser(user: user));
                              },
                              child: UserLabel(
                                  username: user.getFullName(),
                                  image: user.getImage(),
                                  sub: user.sub)),
                      ],
                    );
                  return Loading();
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
