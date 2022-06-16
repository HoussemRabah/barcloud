part of 'categorie_bloc.dart';

@immutable
abstract class CategorieState {}

class CategorieInitial extends CategorieState {}

class CategorieStateLoading extends CategorieState {}

class CategorieStateLoaded extends CategorieState {}

class CategorieStateEmpty extends CategorieState {}

class CategorieStateError extends CategorieState {}
