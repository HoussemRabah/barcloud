import 'package:barcloud/UI/screens/pages/addItemData.dart';
import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/categorie/categorie_bloc.dart';
import '../../../logic/bloc/item/item_bloc.dart';
import '../../../logic/bloc/zone/zone_bloc.dart';
import '../../../logic/functions/navigation.dart';
import '../../../modules/class.dart';
import '../../widgets/cards/itemtype.dart';
import '../../widgets/ui/chips.dart';
import 'login.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
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
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          appBar: AppBar(
            backgroundColor: colorPrime,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<CategorieBloc, CategorieState>(
                builder: (context, state) {
              if (state is CategorieStateLoading) return Loading();
              if (state is CategorieStateLoaded)
                return Column(
                  children: [
                    Text(
                      "categories",
                      style: styleSimplePlus.copyWith(color: colorAccent),
                    ),
                    new ChipsLine(data: [
                      for (Categorie categorie in categorieBloc.categories!)
                        categorie.name
                    ], change: "cat"),
                    if (categorieBloc.selectedCat != "tous")
                      Text(
                        "sous-categories",
                        style: styleSimplePlus.copyWith(color: colorAccent),
                      ),
                    if (categorieBloc.selectedCat != "tous")
                      new ChipsLine(data: [
                        for (SubCategorie categorie
                            in categorieBloc.getSelectedSub())
                          categorie.name
                      ], change: "sub"),
                    SizedBox(
                      height: 8.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: categorieBloc.getSelectedItemsType().length,

                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            openScreen(
                                context,
                                AddItemData(
                                    itemType: categorieBloc
                                        .getSelectedItemsType()[index]));
                          },
                          child: ItemTypeCard(
                              itemType: categorieBloc
                                  .getSelectedItemsType()[index])), // optional
                      // optional
                    ),
                  ],
                );
              return Loading();
            }),
          ),
        ),
      ),
    );
  }
}
