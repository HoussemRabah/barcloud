import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/UI/widgets/textfields/input.dart';
import 'package:barcloud/UI/widgets/textfields/password.dart';
import 'package:barcloud/core/constants.dart';
import 'package:barcloud/logic/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/task/task_bloc.dart';
import '../../../repository/database_repo.dart';

AuthBloc authBloc = AuthBloc(context: null);
DatabaseRepository databaseRepository = DatabaseRepository();
TaskBloc taskBloc = TaskBloc();

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: authBloc..add(AuthEventInit(context: context)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: SvgPicture.asset(
                        "assets/shapeBack.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: Text(
                            "BarCloud",
                            style: styleTitle.copyWith(color: colorPrime),
                          ),
                        ),
                        SizedBox(
                          width: 200.0,
                          child: Text(
                            "Facilitez le travail d'inventaire",
                            style: styleSimple.copyWith(color: colorAccent),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        left: 75.0,
                        top: 100.0,
                        child: Image.asset(
                          "assets/boxes.png",
                          fit: BoxFit.scaleDown,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 300,
                        )),
                  ],
                ),
              ),
              Container(
                color: colorAccent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration:
                      BoxDecoration(borderRadius: radiusHalf, color: colorMain),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthStateLoading)
                        return Loading();
                      else
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  32.0, 32.0, 32.0, 8.0),
                              child: TextFieldInput(
                                hint: "email",
                                textEditingController: username,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  32.0, 0.0, 32.0, 2.0),
                              child: TextFieldPassword(
                                textEditingController: password,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  32.0, 0.0, 32.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "mot de passe oublié?",
                                    style:
                                        styleSmall.copyWith(color: colorAccent),
                                  )
                                ],
                              ),
                            ),
                            if (state is AuthStateError)
                              Text(
                                state.errorMessage,
                                style: styleSimple.copyWith(color: colorRed),
                              ),
                            GestureDetector(
                              onTap: () {
                                authBloc.add(AuthEventSignIn(
                                    email: username.text,
                                    password: password.text));
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: radius, color: colorPrime),
                                width: MediaQuery.of(context).size.width - 32,
                                height: 60.0,
                                child: Center(
                                    child: Text(
                                  "Se connecter",
                                  style: styleSimplePlus.copyWith(
                                      color: colorMain),
                                )),
                              ),
                            ),
                          ],
                        );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
