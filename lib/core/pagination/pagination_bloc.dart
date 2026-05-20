// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/pagination/pagination_event.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';

typedef PaginatedFetch<T> =
    Future<PaginationResult<T>> Function({
      required int page,
      String? search,
      Map<String, dynamic>? filters,
    });

abstract class PaginationBloc<T>
    extends Bloc<PaginationEvent, PaginationState<T>> {
  PaginationBloc({required PaginatedFetch<T> fetchPage})
    : _fetchPage = fetchPage,
      super(PaginationState<T>()) {
    on<PaginationInitialRequested>(_onInitialRequested);
    on<PaginationNextPageRequested>(_onNextPageRequested);
    on<PaginationRefreshRequested>(_onRefreshRequested);
  }

  final PaginatedFetch<T> _fetchPage;

  void fetchInitial({String? search, Map<String, dynamic>? filters}) {
    add(PaginationInitialRequested(search: search, filters: filters));
  }

  void fetchNextPage() {
    add(const PaginationNextPageRequested());
  }

  void refresh() {
    add(const PaginationRefreshRequested());
  }

  Future<void> _onInitialRequested(
    PaginationInitialRequested event,
    Emitter<PaginationState<T>> emit,
  ) async {
    if (state.isLoading || state.isFetchingMore || state.isRefreshing) {
      return;
    }

    await _performFetch(
      emit: emit,
      page: 1,
      appendResults: false,
      isRefreshing: false,
      search: event.search ?? '',
      filters: _normalizeFilters(event.filters),
    );
  }

  Future<void> _onNextPageRequested(
    PaginationNextPageRequested event,
    Emitter<PaginationState<T>> emit,
  ) async {
    if (state.isLoading ||
        state.isFetchingMore ||
        state.isRefreshing ||
        !state.hasMore) {
      return;
    }

    await _performFetch(
      emit: emit,
      page: state.currentPage <= 0 ? 1 : state.currentPage + 1,
      appendResults: true,
      isRefreshing: false,
      search: state.searchQuery,
      filters: state.filters,
    );
  }

  Future<void> _onRefreshRequested(
    PaginationRefreshRequested event,
    Emitter<PaginationState<T>> emit,
  ) async {
    if (state.isLoading || state.isFetchingMore || state.isRefreshing) {
      return;
    }

    await _performFetch(
      emit: emit,
      page: 1,
      appendResults: false,
      isRefreshing: true,
      search: state.searchQuery,
      filters: state.filters,
    );
  }

  Future<void> _performFetch({
    required Emitter<PaginationState<T>> emit,
    required int page,
    required bool appendResults,
    required bool isRefreshing,
    required String search,
    required Map<String, dynamic>? filters,
  }) async {
    final scope = filters?['scope'] as String? ?? 'default';

    emit(
      state.copyWith(
        isLoading: page == 1 && !appendResults && !isRefreshing,
        isSearching: page == 1 && search.isNotEmpty && !isRefreshing,
        isFetchingMore: appendResults,
        isRefreshing: isRefreshing,
        clearError: true,
        searchQuery: search,
        filters: filters,
        items: appendResults
            ? (state.scopedItems[scope] ?? const [])
            : const [],
        currentPage: appendResults ? state.currentPage : 0,
        hasMore: false,
      ),
    );

    try {
      final PaginationResult<T> response = await _fetchPage(
        page: page,
        search: search.isEmpty ? null : search,
        filters: filters,
      );

      final currentList = state.scopedItems[scope] ?? const [];

      final updatedList = appendResults
          ? [...currentList, ...response.items]
          : response.items;

      final updatedScopedItems = Map<String, List<T>>.from(state.scopedItems)
        ..[scope] = updatedList;

      emit(
        state.copyWith(
          isLoading: false,
          isSearching: false,
          isFetchingMore: false,
          isRefreshing: false,
          items: updatedList,
          scopedItems: updatedScopedItems,
          currentScope: scope,
          currentPage: response.currentPage,
          hasMore: response.hasMore,
          totalPages: response.totalPages,
          totalItems: response.totalItems,
          searchQuery: search,
          filters: filters,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSearching: false,
          isFetchingMore: false,
          isRefreshing: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void setScope(String scope) {
    final items = state.scopedItems[scope] ?? const [];

    emit(state.copyWith(currentScope: scope, items: items));
  }

  Map<String, dynamic>? _normalizeFilters(Map<String, dynamic>? filters) {
    if (filters == null || filters.isEmpty) {
      return null;
    }
    return Map<String, dynamic>.from(filters);
  }

  void updateItemEverywhere({
    required bool Function(T item) test,
    required T Function(T item) update,
    Set<String>? targetScopes,
    T? fallbackItem,
  }) {
    final updatedScopedItems = <String, List<T>>{};

    for (final entry in state.scopedItems.entries) {
      final scope = entry.key;
      final list = entry.value;

      // 👇 scope filtering
      if (targetScopes != null && !targetScopes.contains(scope)) {
        updatedScopedItems[scope] = list;
        continue;
      }

      final updatedList = list.map((item) {
        if (!test(item)) return item;
        return update(item);
      }).toList();

      updatedScopedItems[scope] = updatedList;
    }

    final currentScope = state.currentScope;
    final updatedItems = updatedScopedItems[currentScope] ?? state.items;

    T? updatedSelected = state.selectedItem;
    if (updatedSelected != null && test(updatedSelected)) {
      updatedSelected = update(updatedSelected);
    } else {
      if (fallbackItem != null) {
        updatedSelected = fallbackItem;
      }
    }

    emit(
      state.copyWith(
        items: updatedItems,
        scopedItems: updatedScopedItems,
        selectedItem: updatedSelected,
      ),
    );
  }

  // To inser new item at top of the list (e.g. after creating a new tip/guide)
  //  How to use it
  // final newItem = TipsInfoItemModel(
  //   id: response.id,
  //   title: title,
  //   description: description,
  // );
  // bloc.insertItem(
  //   item: newItem,
  //   select: true, // 👈 makes it selected immediately
  // );
  void insertItem({
    required T item,
    bool select = false,
    int? index,
    Set<String>? targetScopes, // 👈 NEW
  }) {
    final updatedScopedItems = <String, List<T>>{};

    for (final entry in state.scopedItems.entries) {
      final scope = entry.key;
      final list = entry.value;

      // 👇 FILTER (THIS IS THE KEY CHANGE)
      if (targetScopes != null && !targetScopes.contains(scope)) {
        updatedScopedItems[scope] = list;
        continue;
      }

      final updatedList = List<T>.from(list);

      if (index != null && index >= 0 && index <= updatedList.length) {
        updatedList.insert(index, item);
      } else {
        updatedList.insert(0, item);
      }

      updatedScopedItems[scope] = updatedList;
    }

    /// fallback (first time case)
    if (updatedScopedItems.isEmpty) {
      final list = List<T>.from(state.items);

      if (index != null && index >= 0 && index <= list.length) {
        list.insert(index, item);
      } else {
        list.insert(0, item);
      }

      updatedScopedItems[state.currentScope] = list;
    }

    final updatedItems = updatedScopedItems[state.currentScope] ?? state.items;

    emit(
      state.copyWith(
        items: updatedItems,
        scopedItems: updatedScopedItems,
        selectedItem: select ? item : state.selectedItem,
      ),
    );
  }

  // Delete the seleted item from the list (e.g. after deleting a tip/guide)
  // bloc.deleteItem(
  //   test: (item) => item.id == deleteId,
  // );
  void deleteItem({
    required bool Function(T item) test,
    Set<String>? targetScopes, // 👈 NEW
  }) {
    final updatedScopedItems = <String, List<T>>{};

    for (final entry in state.scopedItems.entries) {
      final scope = entry.key;
      final list = entry.value;

      // 👇 APPLY SCOPE FILTER
      if (targetScopes != null && !targetScopes.contains(scope)) {
        updatedScopedItems[scope] = list;
        continue;
      }

      final updatedList = list.where((item) => !test(item)).toList();
      updatedScopedItems[scope] = updatedList;
    }

    /// update current visible list
    final currentScope = state.currentScope;
    final updatedItems = updatedScopedItems[currentScope] ?? state.items;

    /// update selected item
    T? updatedSelected = state.selectedItem;
    if (updatedSelected != null && test(updatedSelected)) {
      updatedSelected = null;
    }

    if (updatedSelected == null && updatedItems.isNotEmpty) {
      updatedSelected = updatedItems.first;
    }
    log('🔄 MyReviewPostsBloc rebuild with state: ${updatedItems.length}');
    emit(
      state.copyWith(
        items: updatedItems,
        scopedItems: updatedScopedItems,
        selectedItem: updatedSelected,
      ),
    );
  }

  void rollbackFailedEverywhere({required List<T> items, T? selectedItem}) {
    emit(state.copyWith(items: items, selectedItem: selectedItem));
  }

  void startProcessing(String id, String action) {
    final current = Map<String, Set<String>>.from(state.processingMap);

    final actions = current[id] ?? <String>{};
    current[id] = {...actions, action};

    emit(state.copyWith(processingMap: current));
  }

  void stopProcessing(String id, String action) {
    final current = Map<String, Set<String>>.from(state.processingMap);

    if (!current.containsKey(id)) return;

    final actions = {...current[id]!}..remove(action);

    if (actions.isEmpty) {
      current.remove(id);
    } else {
      current[id] = actions;
    }

    emit(state.copyWith(processingMap: current));
  }
}
