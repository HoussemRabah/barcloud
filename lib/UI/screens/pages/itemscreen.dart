import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/UI/screens/views/qrView.dart';
import 'package:barcloud/UI/widgets/cards/dataCard.dart';
import 'package:barcloud/UI/widgets/loading/loading.dart';
import 'package:barcloud/UI/widgets/textfields/input.dart';
import 'package:barcloud/logic/functions/navigation.dart';
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
TextEditingController textEditingController = new TextEditingController();
Map edit = {"name": null, "value": null, "id": null};

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
            actions: [
              GestureDetector(
                  onTap: () {
                    openScreen(context, QrView(text: widget.itemId));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.print,
                      color: colorMain,
                    ),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemStateLoaded)
                  return Column(
                    children: [
                      for (ItemData itemData in itemBloc.data ?? [])
                        GestureDetector(
                          onTap: () {
                            if (itemData.customAcess)
                              showBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  edit["name"] = itemData.champName;
                                  textEditingController.text = itemData.data;
                                  edit["value"] = itemData.data;
                                  edit["id"] = itemData.dataId;
                                  return Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: radiusHalf,
                                        color: colorMain),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFieldInput(
                                              hint: edit["name"] ?? "",
                                              textEditingController:
                                                  textEditingController),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            bool result =
                                                await databaseRepository
                                                    .changeData(
                                                        itemData.dataId,
                                                        widget.itemId,
                                                        authBloc.authRepository
                                                            .user!.id,
                                                        textEditingController
                                                            .text);
                                            if (result) {
                                              newScreen(
                                                  context,
                                                  ItemScreen(
                                                      itemId: widget.itemId));
                                            } else {
                                              print("no");
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: colorPrime),
                                            padding: EdgeInsets.all(16.0),
                                            child: Text(
                                              "changer",
                                              style: styleSimplePlus.copyWith(
                                                  color: colorMain),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                          },
                          child: DataCard(
                              acess: itemData.customAcess,
                              name: itemData.champName,
                              value: itemData.data),
                        )
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
