part of 'item_bloc.dart';

@immutable
abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemStateLoaded extends ItemState {}

class ItemStateLoading extends ItemState {}

class ItemStateError extends ItemState {}
