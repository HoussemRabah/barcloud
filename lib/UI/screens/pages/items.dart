import 'package:barcloud/UI/screens/pages/itemscreen.dart';
import 'package:barcloud/UI/widgets/cards/item.dart';
import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/UI/widgets/ui/chips.dart';
import 'package:barcloud/core/constants.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../logic/bloc/categorie/categorie_bloc.dart';
import '../../../logic/bloc/zone/zone_bloc.dart';
import '../../../modules/class.dart';
import 'login.dart';

class ItemsScreen extends StatefulWidget {
  final Zone zone;
  const ItemsScreen({Key? key, required this.zone}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategorieBloc>.value(
          value: categorieBloc..add(CategorieEventFetch(zone: widget.zone)),
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
              child: BlocBuilder<CategorieBloc, CategorieState>(
                builder: (context, state) {
                  if (state is CategorieStateLoaded)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        GroupedListView<Item, String>(
                          shrinkWrap: true,
                          elements: categorieBloc.getSelectedItems(),
                          groupBy: (element) => element.type.name,
                          groupSeparatorBuilder: (String groupByValue) => Text(
                            groupByValue,
                            style: styleSimplePlus.copyWith(color: colorAccent),
                          ),
                          itemBuilder: (context, Item element) =>
                              GestureDetector(
                                  onTap: () {
                                    openScreen(context,
                                        ItemScreen(itemId: element.id));
                                  },
                                  child: ItemCard(item: element)), // optional
                          useStickyGroupSeparators: true, // optional
                          floatingHeader: true, // optional
                          order: GroupedListOrder.ASC, // optional
                        ),
                      ],
                    );
                  else if (state is CategorieStateError)
                    return Text("error");
                  else
                    return Loading();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
