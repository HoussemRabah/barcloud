part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class ItemEventFetch extends ItemEvent {
  String itemId;
  ItemEventFetch({required this.itemId}) : super();
}
