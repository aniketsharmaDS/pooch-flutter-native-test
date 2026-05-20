import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_event.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_event.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_state.dart';
import 'package:poochcare/features/community/repository/community_repository.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CommunityRepository repository;
  final CommunityStoreBloc store;

  CategoriesBloc({required this.repository, required this.store})
    : super(const CategoriesInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(
    FetchCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(const CategoriesLoading());

    try {
      /// 1. CALL REPOSITORY
      final categories = await repository.getTipsCategories();

      /// 2. SAVE IN STORE (IMPORTANT)
      store.add(CommunityCategoriesUpserted(categories));

      /// 3. SUCCESS STATE
      emit(const CategoriesSuccess());
    } catch (e) {
      /// 4. ERROR STATE
      emit(CategoriesError(e.toString()));
    }
  }
}
