import 'package:flutter/material.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/enums/medical_history_record_type_filter.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/list_items/medical_history_list_item_card.dart';
import 'package:poochcare/features/medical_history/domain/models/medical_history_record.dart';
import 'package:poochcare/features/medical_history/presentation/widgets/medical_history_filters_scope.dart';
import 'package:poochcare/features/medical_history/repository/medical_history_repository.dart';

class MedicalHistoryRecordsTabList extends StatefulWidget {
  const MedicalHistoryRecordsTabList({super.key, this.recordType});

  final MedicalHistoryRecordTypeFilter? recordType;

  @override
  State<MedicalHistoryRecordsTabList> createState() =>
      _MedicalHistoryRecordsTabListState();
}

class _MedicalHistoryRecordsTabListState
    extends State<MedicalHistoryRecordsTabList>
    with AutomaticKeepAliveClientMixin {
  static const int _pageSize = 10;

  final MedicalHistoryRepository _repository =
      getIt<MedicalHistoryRepository>();
  final List<MedicalHistoryItem> _items = <MedicalHistoryItem>[];

  ValueNotifier<DateTimeRange>? _dateRangeNotifier;
  ValueNotifier<String?>? _petIdNotifier;
  ValueNotifier<int>? _activeTabIndexNotifier;
  ValueNotifier<int>? _refreshSignalNotifier;

  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMessage;
  int _page = 1;

  int get _tabIndex {
    return switch (widget.recordType) {
      null => 0,
      MedicalHistoryRecordTypeFilter.consultation => 1,
      MedicalHistoryRecordTypeFilter.vaccination => 2,
      MedicalHistoryRecordTypeFilter.labReport => 3,
      MedicalHistoryRecordTypeFilter.healthRecords => 4,
      MedicalHistoryRecordTypeFilter.otherDocuments => 5,
    };
  }

  bool get _isActiveTab => _activeTabIndexNotifier?.value == _tabIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final scope = MedicalHistoryFiltersScope.of(context);

    final hasDateNotifierChanged =
        _dateRangeNotifier != scope.selectedDateRangeNotifier;
    final hasPetNotifierChanged = _petIdNotifier != scope.selectedPetIdNotifier;
    final hasActiveTabNotifierChanged =
        _activeTabIndexNotifier != scope.activeTabIndexNotifier;
    final hasRefreshSignalNotifierChanged =
        _refreshSignalNotifier != scope.refreshSignalNotifier;

    if (!hasDateNotifierChanged &&
        !hasPetNotifierChanged &&
        !hasActiveTabNotifierChanged &&
        !hasRefreshSignalNotifierChanged) {
      return;
    }

    _dateRangeNotifier?.removeListener(_onFiltersChanged);
    _petIdNotifier?.removeListener(_onFiltersChanged);
    _activeTabIndexNotifier?.removeListener(_onActiveTabChanged);
    _refreshSignalNotifier?.removeListener(_onRefreshSignalChanged);

    _dateRangeNotifier = scope.selectedDateRangeNotifier;
    _petIdNotifier = scope.selectedPetIdNotifier;
    _activeTabIndexNotifier = scope.activeTabIndexNotifier;
    _refreshSignalNotifier = scope.refreshSignalNotifier;

    _dateRangeNotifier?.addListener(_onFiltersChanged);
    _petIdNotifier?.addListener(_onFiltersChanged);
    _activeTabIndexNotifier?.addListener(_onActiveTabChanged);
    _refreshSignalNotifier?.addListener(_onRefreshSignalChanged);

    if (_isActiveTab) {
      _loadInitial();
    }
  }

  @override
  void dispose() {
    _dateRangeNotifier?.removeListener(_onFiltersChanged);
    _petIdNotifier?.removeListener(_onFiltersChanged);
    _activeTabIndexNotifier?.removeListener(_onActiveTabChanged);
    _refreshSignalNotifier?.removeListener(_onRefreshSignalChanged);
    super.dispose();
  }

  void _onFiltersChanged() {
    if (_isActiveTab) {
      _loadInitial();
    }
  }

  void _onActiveTabChanged() {
    if (_isActiveTab) {
      _loadInitial();
    }
  }

  void _onRefreshSignalChanged() {
    if (_isActiveTab) {
      _loadInitial();
    }
  }

  Future<void> _loadInitial() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = true;
      _isLoadingMore = false;
      _errorMessage = null;
      _hasMore = true;
      _page = 1;
      _items.clear();
    });

    try {
      final result = await _fetchPage(page: 1);
      if (!mounted) {
        return;
      }
      setState(() {
        _items.addAll(result.records.map(_toListItem).toList(growable: false));
        _hasMore = result.hasMore;
        _page = 2;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
        _errorMessage = error.toString();
      });
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore || _isLoading) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoadingMore = true;
      _errorMessage = null;
    });

    try {
      final result = await _fetchPage(page: _page);
      if (!mounted) {
        return;
      }
      setState(() {
        _items.addAll(result.records.map(_toListItem).toList(growable: false));
        _hasMore = result.hasMore;
        _page += 1;
        _isLoadingMore = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoadingMore = false;
        _errorMessage = error.toString();
      });
    }
  }

  Future<void> _refresh() async {
    await _loadInitial();
  }

  Future<PaginatedMedicalHistoryRecords> _fetchPage({required int page}) async {
    final dateRange = _dateRangeNotifier?.value;
    final petId = _petIdNotifier?.value?.trim();

    return _repository.getMedicalHistoryRecords(
      petId: petId == null || petId.isEmpty ? null : petId,
      recordType: widget.recordType?.apiValue,
      startDate: dateRange?.start,
      endDate: dateRange?.end,
      page: page,
      limit: _pageSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppPaginatedListView<MedicalHistoryItem>(
      items: _items,
      isLoading: _isLoading,
      isLoadingMore: _isLoadingMore,
      hasMore: _hasMore,
      hasError: _errorMessage != null,
      error: _errorMessage,
      onLoadMore: _loadMore,
      onRefresh: _refresh,
      onRetry: _loadInitial,
      itemBuilder: (item, index) {
        return MedicalHistoryListItemCard(item: item);
      },
    );
  }

  MedicalHistoryItem _toListItem(MedicalHistoryRecord record) {
    return MedicalHistoryItem(
      title: _labelForRecordType(record.recordType),
      type: _itemTypeForRecordType(record.recordType),
      data: MedicalData(
        recordId: record.recordId,
        appointmentId: record.appointmentId,
        title: record.title,
        subtitle: _readableDate(record.secondaryText),
        dateTime: record.primaryText.trim().isEmpty
            ? record.tertiaryText
            : record.primaryText,
        documents: record.documents
            .map(
              (doc) => MedicalDocument(
                fileName: doc.fileName,
                fileSize: _formatDocumentSize(doc.fileSize),
                fileType: doc.fileType,
                url: doc.url,
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  String _labelForRecordType(String rawType) {
    final type = rawType.toLowerCase();
    if (type.contains('vacc')) {
      return 'Vaccination';
    }
    if (type.contains('lab')) {
      return 'Lab Report';
    }
    if (type.contains('document')) {
      return 'Other Documents';
    }
    if (type.contains('consult') || type.contains('diagnosis')) {
      return 'Consultation';
    }
    return 'Medical Record';
  }

  ItemType _itemTypeForRecordType(String rawType) {
    final type = rawType.toLowerCase();
    if (type.contains('vacc')) {
      return ItemType.vaccination;
    }
    if (type.contains('lab')) {
      return ItemType.labReport;
    }
    if (type.contains('consult') || type.contains('diagnosis')) {
      return ItemType.consultation;
    }
    return ItemType.prescription;
  }

  String _readableDate(String rawDate) {
    final input = rawDate.trim();
    if (input.isEmpty) {
      return '';
    }

    final parsed = DateTime.tryParse(input);
    if (parsed == null) {
      return input;
    }

    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final day = parsed.day.toString().padLeft(2, '0');
    final month = months[parsed.month - 1];
    return '$day $month ${parsed.year}';
  }

  String _formatDocumentSize(String rawSize) {
    final size = int.tryParse(rawSize.trim());
    if (size == null || size <= 0) {
      return rawSize.trim().isEmpty ? ' ' : rawSize;
    }

    const kb = 1024;
    const mb = 1024 * 1024;

    if (size >= mb) {
      final value = size / mb;
      return '${value.toStringAsFixed(value >= 10 ? 1 : 2)} MB';
    }

    if (size >= kb) {
      final value = size / kb;
      return '${value.toStringAsFixed(value >= 10 ? 1 : 2)} KB';
    }

    return '$size B';
  }
}
