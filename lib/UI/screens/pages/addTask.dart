import 'package:barcloud/UI/screens/pages/addTaskscreen.dart';
import 'package:barcloud/UI/widgets/users/userlabel.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/user/user_bloc.dart';
import '../../../logic/functions/navigation.dart';
import '../../widgets/loading/loading.dart';
import 'login.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>.value(
          value: userBloc..add(UserEventFetch()),
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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserStateLoaded)
                      return Column(
                        children: [
                          for (TheUser user in userBloc.users!
                              .where((element) => element.role.name == "agent"))
                            GestureDetector(
                                onTap: () {
                                  openScreen(context,
                                      AddTaskDataScreen(agentId: user.id));
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
    );
  }
}
