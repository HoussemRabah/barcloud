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

  String getSelected(String change) {
    switch (change) {
      case "zone":
        return selectedZone;

      case "cat":
        return selectedCat;

      default:
        return selectedSub;
    }
  }

  List<ItemType> getSelectedItemsType() {
    return itemTypes!
        .where((element) => ((subCategories!
                    .where((e) => e.id == element.subCategoryId)
                    .first
                    .name ==
                selectedSub ||
            selectedSub == "tous")))
        .toList();
  }

  List<Item> getSelectedItems() {
    return items!
        .where((element) =>
            ((element.type.name == selectedType || selectedType == "tous") &&
                (subCategories!
                            .where((e) => e.id == element.type.subCategoryId)
                            .first
                            .name ==
                        selectedSub ||
                    selectedSub == "tous")))
        .toList();
  }

  List<SubCategorie> getSelectedSub() {
    return subCategories!
        .where((element) =>
            ((element.name == selectedSub || selectedSub == "tous")))
        .toList();
  }

  CategorieBloc() : super(CategorieInitial()) {
    on<CategorieEvent>((event, emit) async {
      if (event is CategorieEventChange) {
        switch (event.change) {
          case "zone":
            selectedZone = event.value;
            break;
          case "cat":
            selectedCat = event.value;
            break;
          case "sub":
            selectedSub = event.value;
            break;
        }
        emit(CategorieStateLoaded());
      }

      if (event is CategorieEventFetch) {
        emit(CategorieStateLoading());
        categories = await databaseRepository.getCategories();

        subCategories = await databaseRepository.getSubCategories();

        itemTypes = await databaseRepository.getItemTypes();
        if (event.zone != null)
          items = await databaseRepository.getItems(itemTypes ?? []) ?? []
            ..where((element) => element.zoneId == event.zone!.id).toList();

        if (categories == null ||
            subCategories == null ||
            itemTypes == null ||
            items == null)
          emit(CategorieStateError());
        else {
          emit(CategorieStateLoaded());
        }
      }
    });
  }
}
