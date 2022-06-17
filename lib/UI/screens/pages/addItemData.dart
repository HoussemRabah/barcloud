import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/UI/widgets/textfields/input.dart';
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
                    for (DataChamp dataChamp in datachampBloc.dataChamps!)
                      TextFieldInput(
                          hint: dataChamp.name,
                          textEditingController:
                              datachampBloc.textcon[dataChamp.id] ??
                                  TextEditingController())
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
