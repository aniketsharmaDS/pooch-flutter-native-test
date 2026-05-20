import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/community/community_store_event.dart';
import 'package:poochcare/core/store/community/community_store_state.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';

class CommunityStoreBloc
    extends Bloc<CommunityStoreEvent, CommunityStoreState> {
  CommunityStoreBloc() : super(const CommunityStoreState()) {
    on<CommunityCategoriesUpserted>(_onCategoriesUpserted);
    on<CommunityCleared>(_onCleared);
  }

  void _onCategoriesUpserted(
    CommunityCategoriesUpserted event,
    Emitter<CommunityStoreState> emit,
  ) {
    final Map<String, TipsCategoryModel> updatedMap = {...state.categoriesById};

    final List<String> updatedIds = List.from(state.categoryIds);

    for (final category in event.categories) {
      updatedMap[category.id] = category;

      if (!updatedIds.contains(category.id)) {
        updatedIds.add(category.id);
      }
    }

    emit(state.copyWith(categoriesById: updatedMap, categoryIds: updatedIds));
  }

  void _onCleared(CommunityCleared event, Emitter<CommunityStoreState> emit) {
    emit(const CommunityStoreState());
  }
}
