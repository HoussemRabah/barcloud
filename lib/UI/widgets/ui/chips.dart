import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/core/constants.dart';
import 'package:barcloud/logic/bloc/categorie/categorie_bloc.dart';
import 'package:flutter/material.dart';

class ChipsLine extends StatefulWidget {
  final List<String> data;
  final String change;
  const ChipsLine({Key? key, required this.data, required this.change})
      : super(key: key);

  @override
  State<ChipsLine> createState() => _ChipsLineState();
}

class _ChipsLineState extends State<ChipsLine> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              categorieBloc.add(
                  CategorieEventChange(change: widget.change, value: "tous"));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: radius,
                  color: (categorieBloc.getSelected(widget.change) == "tous")
                      ? colorPrime
                      : colorMain),
              margin: EdgeInsets.all(4.0),
              padding: EdgeInsets.all(4.0),
              child: Text(
                "tous",
                style: styleSmall.copyWith(
                    color: (categorieBloc.getSelected(widget.change) == "tous")
                        ? colorMain
                        : colorFront),
              ),
            ),
          ),
          for (String item in widget.data)
            GestureDetector(
              onTap: () {
                categorieBloc.add(
                    CategorieEventChange(change: widget.change, value: item));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: radius,
                    color: (categorieBloc.getSelected(widget.change) == item)
                        ? colorPrime
                        : colorMain),
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(4.0),
                child: Text(
                  item,
                  style: styleSmall.copyWith(
                      color: (categorieBloc.getSelected(widget.change) == item)
                          ? colorMain
                          : colorFront),
                ),
              ),
            )
        ],
      ),
    );
  }
}
