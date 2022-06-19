import 'package:barcloud/UI/screens/views/qrView.dart';
import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/UI/widgets/textfields/input.dart';
import 'package:barcloud/UI/widgets/ui/chips.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/categorie/categorie_bloc.dart';
import '../../../logic/bloc/datachamp/datachamp_bloc.dart';
import '../../../logic/bloc/zone/zone_bloc.dart';
import 'login.dart';

class AddItemData extends StatefulWidget {
  final ItemType itemType;
  const AddItemData({Key? key, required this.itemType}) : super(key: key);

  @override
  State<AddItemData> createState() => _AddItemDataState();
}

Zone? _selected = null;

class _AddItemDataState extends State<AddItemData> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ZoneBloc>.value(
          value: zoneBloc..add(ZoneEventFetch()),
        ),
        BlocProvider<CategorieBloc>.value(
          value: categorieBloc..add(CategorieEventFetch(zone: null)),
        ),
        BlocProvider<DatachampBloc>.value(
          value: datachampBloc
            ..add(DatachampEventFetch(itemTypeId: widget.itemType.id)),
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
              child: BlocBuilder<DatachampBloc, DatachampState>(
            builder: (context, state) {
              if (state is DatachampStateLoaded)
                return Column(
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
                    for (DataChamp dataChamp in datachampBloc.dataChamps!)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldInput(
                            hint: dataChamp.name,
                            textEditingController:
                                datachampBloc.textcon[dataChamp.id] ??
                                    TextEditingController()),
                      ),
                    GestureDetector(
                      onTap: () async {
                        datachampBloc.add(DatachampEventCreate(
                            context: context,
                            itemTypeId: widget.itemType.id,
                            zoneId: _selected!.id));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: radius, color: colorPrime),
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          "ajouter",
                          style: styleSimplePlus.copyWith(color: colorFront),
                        ),
                      ),
                    )
                  ],
                );
              return Loading();
            },
          )),
        ),
      ),
    );
  }
}
