import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../UI/screens/pages/login.dart';
import '../../../modules/class.dart';

part 'categorie_event.dart';
part 'categorie_state.dart';

class CategorieBloc extends Bloc<CategorieEvent, CategorieState> {
  String selectedZone = "tous";
  String selectedCat = "tous";
  String selectedSub = "tous";
  String selectedType = "tous";

  List<Categorie>? categories = [];
  List<SubCategorie>? subCategories = [];
  List<ItemType>? itemTypes = [];
  List<Item>? items = [];
  CategorieBloc() : super(CategorieInitial()) {
    on<CategorieEvent>((event, emit) async {
      if (event is CategorieEventFetch) {
        emit(CategorieStateLoading());
        categories = await databaseRepository.getCategories();

        subCategories = await databaseRepository.getSubCategories();

        itemTypes = await databaseRepository.getItemTypes();

        items = await databaseRepository.getItems(itemTypes ?? []);

        if (categories == null ||
            subCategories == null ||
            itemTypes == null ||
            items == null)
          emit(CategorieStateError());
        else
          emit(CategorieStateLoaded());
      }
    });
  }
}
