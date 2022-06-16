import 'package:barcloud/UI/screens/pages/items.dart';
import 'package:barcloud/UI/widgets/cards/zones.dart';
import 'package:barcloud/UI/widgets/headers/headerInv.dart';
import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/zone/zone_bloc.dart';
import '../../../modules/class.dart';
import 'login.dart';

class InvScreen extends StatefulWidget {
  const InvScreen({Key? key}) : super(key: key);

  @override
  State<InvScreen> createState() => _InvScreenState();
}

class _InvScreenState extends State<InvScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ZoneBloc>.value(
          value: zoneBloc..add(ZoneEventFetch()),
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
                BlocBuilder<ZoneBloc, ZoneState>(
                  builder: (context, state) {
                    if (state is ZoneStateLoaded)
                      return HeaderInv(zonesAvailble: zoneBloc.zones!.length);
                    return Loading();
                  },
                ),
                BlocBuilder<ZoneBloc, ZoneState>(
                  builder: (context, state) {
                    if (state is ZoneStateLoaded)
                      return Column(
                        children: [
                          for (Zone zone in zoneBloc.zones!)
                            GestureDetector(
                                onTap: () {
                                  openScreen(context, ItemsScreen(zone: zone,));
                                },
                                child: ZoneCard(zone: zone)),
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
