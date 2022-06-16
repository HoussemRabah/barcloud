import 'package:barcloud/UI/widgets/cards/item.dart';
import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/UI/widgets/ui/chips.dart';
import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../logic/bloc/categorie/categorie_bloc.dart';
import '../../../logic/bloc/zone/zone_bloc.dart';
import '../../../modules/class.dart';
import 'login.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ZoneBloc>.value(
          value: zoneBloc..add(ZoneEventFetch()),
        ),
        BlocProvider<CategorieBloc>.value(
          value: categorieBloc..add(CategorieEventFetch()),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "zones",
                    style: styleSimplePlus.copyWith(color: colorAccent),
                  ),
                  BlocBuilder<ZoneBloc, ZoneState>(
                    builder: (context, state) {
                      if (state is ZoneStateLoaded)
                        return ChipsLine(data: [
                          for (Zone zone in zoneBloc.zones!) zone.name
                        ], todo: () {});
                      return Loading();
                    },
                  ),
                  Text(
                    "categories",
                    style: styleSimplePlus.copyWith(color: colorAccent),
                  ),
                  BlocBuilder<CategorieBloc, CategorieState>(
                    builder: (context, state) {
                      if (state is CategorieStateLoaded)
                        return ChipsLine(data: [
                          for (Categorie categorie in categorieBloc.categories!)
                            categorie.name
                        ], todo: () {});
                      return Loading();
                    },
                  ),
                  Text(
                    "sous-categories",
                    style: styleSimplePlus.copyWith(color: colorAccent),
                  ),
                  BlocBuilder<CategorieBloc, CategorieState>(
                    builder: (context, state) {
                      if (state is CategorieStateLoaded)
                        return ChipsLine(data: [
                          for (SubCategorie categorie
                              in categorieBloc.subCategories!)
                            categorie.name
                        ], todo: () {});
                      return Loading();
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  BlocBuilder<CategorieBloc, CategorieState>(
                    builder: (context, state) {
                      if (state is CategorieStateLoaded)
                        return GroupedListView<Item, String>(
                          shrinkWrap: true,
                          elements: categorieBloc.items ?? [],
                          groupBy: (element) => element.type.name,
                          groupSeparatorBuilder: (String groupByValue) => Text(
                            groupByValue,
                            style: styleSimplePlus.copyWith(color: colorAccent),
                          ),
                          itemBuilder: (context, Item element) =>
                              ItemCard(item: element), // optional
                          useStickyGroupSeparators: true, // optional
                          floatingHeader: true, // optional
                          order: GroupedListOrder.ASC, // optional
                        );
                      return Loading();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
