import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../logic/bloc/event/event_bloc.dart';
import '../../../logic/bloc/item/item_bloc.dart';
import '../../../modules/class.dart';
import '../../widgets/cards/eventCard.dart';
import '../../widgets/loading/loading.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: eventBloc..add(EventEventFetch()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          appBar: AppBar(
            backgroundColor: colorPrime,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is EventStateLoaded)
                  return Column(
                    children: [
                      for (Event itemData in eventBloc.events ?? [])
                        EventCard(
                          event: itemData,
                        ),
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
