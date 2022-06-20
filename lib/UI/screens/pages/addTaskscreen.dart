import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/event/event_bloc.dart';
import '../../../logic/bloc/zone/zone_bloc.dart';
import '../../../modules/class.dart';
import '../../widgets/loading/loading.dart';
import '../../widgets/textfields/input.dart';

class AddTaskDataScreen extends StatefulWidget {
  final String agentId;
  const AddTaskDataScreen({Key? key, required this.agentId}) : super(key: key);

  @override
  State<AddTaskDataScreen> createState() => _AddTaskDataScreenState();
}

Zone? _selected;
String _selectedType = "add";
TextEditingController title = TextEditingController();
TextEditingController disc = TextEditingController();
TextEditingController deadline = TextEditingController();
TextEditingController type = TextEditingController();

class _AddTaskDataScreenState extends State<AddTaskDataScreen> {
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
          backgroundColor: colorBack,
          appBar: AppBar(
            backgroundColor: colorPrime,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              BlocBuilder<ZoneBloc, ZoneState>(
                builder: (context, state) {
                  if (state is ZoneStateLoaded) {
                    if (_selected == null)
                      _selected = (zoneBloc.zones ?? []).first;
                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (Zone zone in zoneBloc.zones ?? [])
                              GestureDetector(
                                onTap: () {
                                  _selected = zone;
                                  zoneBloc.add(ZoneEventRefresh());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: radius,
                                      color: (_selected == zone)
                                          ? colorPrime
                                          : colorMain),
                                  padding: EdgeInsets.all(4.0),
                                  margin: EdgeInsets.all(4.0),
                                  child: Text(
                                    zone.name,
                                    style: styleSimple.copyWith(
                                        color: (_selected == zone)
                                            ? colorMain
                                            : colorFront),
                                  ),
                                ),
                              )
                          ],
                        ));
                  }
                  return Loading();
                },
              ),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectedType = "add";
                              eventBloc.add(EventEventRefresh());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: radius,
                                  color: (_selectedType == "add")
                                      ? colorPrime
                                      : colorMain),
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(4.0),
                              child: Text(
                                "ajouter item",
                                style: styleSimple.copyWith(
                                    color: (_selectedType == "add")
                                        ? colorMain
                                        : colorFront),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedType = "checklist";
                              eventBloc.add(EventEventRefresh());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: radius,
                                  color: (_selectedType == "checklist")
                                      ? colorPrime
                                      : colorMain),
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(4.0),
                              child: Text(
                                "checklist",
                                style: styleSimple.copyWith(
                                    color: (_selectedType == "checklist")
                                        ? colorMain
                                        : colorFront),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedType = "edit";
                              eventBloc.add(EventEventRefresh());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: radius,
                                  color: (_selectedType == "edit")
                                      ? colorPrime
                                      : colorMain),
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.all(4.0),
                              child: Text(
                                "modifier item",
                                style: styleSimple.copyWith(
                                    color: (_selectedType == "edit")
                                        ? colorMain
                                        : colorFront),
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    TextFieldInput(hint: 'titre', textEditingController: title),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    TextFieldInput(hint: 'disc', textEditingController: disc),
              ),
              GestureDetector(
                onTap: () async {
                  eventBloc.add(EventEventCreate(
                      context: context,
                      title: title.text,
                      disc: disc.text,
                      agentId: widget.agentId,
                      adminId: authBloc.authRepository.user!.id,
                      deadline: deadline.text,
                      type: _selectedType,
                      zoneId: _selected!.id));
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: radius, color: colorPrime),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  child: Text(
                    "ajouter",
                    style: styleSimplePlus.copyWith(color: colorFront),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
    ;
  }
}
