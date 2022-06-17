import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/item/item_bloc.dart';

class ItemScreen extends StatefulWidget {
  final String itemId;
  const ItemScreen({Key? key, required this.itemId}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

ItemBloc itemBloc = ItemBloc();

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: itemBloc..add(ItemEventFetch(itemId: widget.itemId)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          appBar: AppBar(
            backgroundColor: colorPrime,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemStateLoaded)
                  return Column(
                    children: [
                      for (ItemData itemData in itemBloc.data ?? [])
                        Text("${itemData.champName} : ${itemData.data}")
                    ],
                  );
                return Loading();
              },
            ),
          ),
        ),
      ),
    );
  }
}
