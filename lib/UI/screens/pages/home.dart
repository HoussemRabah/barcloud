import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("welcome ${authBloc.authRepository.user!.getFullName()}"),
            Text("role : ${authBloc.authRepository.user!.role.name}"),
          ],
        ),
      ),
    );
  }
}
