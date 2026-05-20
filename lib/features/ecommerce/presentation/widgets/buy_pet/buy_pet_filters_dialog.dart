import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/widgets/dialogs/app_filter_dialog.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_filters_model.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet/buy_pet_bloc.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';

class BuyPetFiltersDialog {
  static Future<CustomFilterResult?> show(BuildContext context) async {
    final bloc = context.read<BuyPetBloc>();
    final state = bloc.state;

    // ❗ If data not ready → do nothing (listener will handle)
    if (state.filters == null) return null;

    return _openDialog(context, state);
  }

  static Future<CustomFilterResult?> _openDialog(
    BuildContext context,
    BuyPetState state,
  ) {
    return AppFilterDialog.show(
      context,
      sections: _mapToSections(state.filters!, state.breeds),
      initialSelectedValues: state.appliedFilters,
    );
  }

  static List<FilterSectionItem> _mapToSections(
    ProductFilters f,
    List<Breed> breeds,
  ) {
    return [
      _section('Age', 'lifeStage', f.lifeStages),
      _section('Gender', 'gender', f.genders),
      if (breeds.isNotEmpty) _breedSection(breeds),
      _section('Size', 'size', f.sizes, single: true),
      _section('Energy', 'energyLevel', f.energyLevels),
      _section('Grooming', 'grooming', f.groomingNeeds),
      _section('Temperament', 'temperament', f.temperaments),
      // _section('Category', 'subcategory', f.subcategories),
      _section('Allergies', 'allergy', f.allergies),
    ];
  }

  static FilterSectionItem _section(
    String title,
    String id,
    List<String> values, {
    bool single = false,
  }) {
    return FilterSectionItem(
      id: id,
      title: title,
      selectionType: single
          ? FilterSelectionType.single
          : FilterSelectionType.multiple,
      options: values
          .map((e) => FilterOptionItem(id: e, label: _format(e)))
          .toList(),
    );
  }

  static FilterSectionItem _breedSection(List<Breed> breeds) {
    return FilterSectionItem(
      id: 'breed',
      title: 'Breed',
      enableSearch: true,
      searchHint: 'Type breed',
      selectionType: FilterSelectionType.multiple,
      options: breeds
          .map((b) => FilterOptionItem(id: b.id, label: b.name))
          .toList(),
    );
  }

  static String _format(String value) {
    return value
        .replaceAll('_', ' ')
        .split(' ')
        .map((e) => e.isEmpty ? e : e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }
}
