import 'package:barcloud/UI/widgets/textfields/input.dart';
import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBack,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SvgPicture.asset(
                    "assets/shapeBack.svg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "BarCloud",
                          style: styleTitle.copyWith(color: colorPrime),
                        ),
                      ),
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          "Facilitez le travail d'inventaire",
                          style: styleSimplePlus.copyWith(color: colorAccent),
                        ),
                      ),
                      SizedBox(
                        height: 64.0,
                      ),
                      Image.asset("assets/boxes.png",
                          width: MediaQuery.of(context).size.width * 0.75,
                          fit: BoxFit.scaleDown),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration:
                  BoxDecoration(borderRadius: radiusHalf, color: colorFront),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8.0),
                    child: TextFieldInput(hint: "email"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 8.0),
                    child: TextFieldInput(hint: "password"),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                          borderRadius: radiusHalf, color: colorPrime),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                        "Se connecter",
                        style: styleSimplePlus.copyWith(color: colorFront),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
