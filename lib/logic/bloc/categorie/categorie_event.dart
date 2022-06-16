part of 'categorie_bloc.dart';

@immutable
abstract class CategorieEvent {}

class CategorieEventInit extends CategorieEvent {}

class CategorieEventFetch extends CategorieEvent {
  Zone zone;
  CategorieEventFetch({required this.zone}) : super();
}

class CategorieEventChange extends CategorieEvent {
  String change;
  String value;
  CategorieEventChange({required this.change, required this.value}) : super();
}
