class MedicalHistoryRecordsPageResponse {
  const MedicalHistoryRecordsPageResponse({
    required this.records,
    required this.hasMore,
  });

  final List<Map<String, dynamic>> records;
  final bool hasMore;

  factory MedicalHistoryRecordsPageResponse.fromPayload(
    dynamic payload, {
    required int page,
    required int limit,
  }) {
    final records = _extractRecords(payload);

    if (payload is! Map<String, dynamic>) {
      return MedicalHistoryRecordsPageResponse(
        records: records,
        hasMore: records.length >= limit,
      );
    }

    final bool? explicitHasMore = _asBool(payload['hasMore']);
    if (explicitHasMore != null) {
      return MedicalHistoryRecordsPageResponse(
        records: records,
        hasMore: explicitHasMore,
      );
    }

    final int currentPage =
        _asInt(payload['page']) ??
        _asInt(payload['currentPage']) ??
        _asInt(_readFromMap(payload['pagination'], 'page')) ??
        _asInt(payload['pageNumber']) ??
        page;

    final int? totalPages =
        _asInt(payload['totalPages']) ??
        _asInt(_readFromMap(payload['pagination'], 'totalPages')) ??
        _asInt(payload['lastPage']) ??
        _asInt(payload['pages']);

    if (totalPages != null && totalPages > 0) {
      return MedicalHistoryRecordsPageResponse(
        records: records,
        hasMore: currentPage < totalPages,
      );
    }

    return MedicalHistoryRecordsPageResponse(
      records: records,
      hasMore: records.length >= limit,
    );
  }

  static List<Map<String, dynamic>> _extractRecords(dynamic payload) {
    if (payload is List) {
      return payload.whereType<Map<String, dynamic>>().toList(growable: false);
    }

    if (payload is! Map<String, dynamic>) {
      return const <Map<String, dynamic>>[];
    }

    final dynamic listNode =
        payload['records'] ??
        payload['items'] ??
        payload['medicalHistory'] ??
        payload['medicalHistories'] ??
        payload['list'] ??
        payload['data'];

    if (listNode is! List) {
      return const <Map<String, dynamic>>[];
    }

    return listNode.whereType<Map<String, dynamic>>().toList(growable: false);
  }

  static int? _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value.trim());
    }
    return null;
  }

  static bool? _asBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true') {
        return true;
      }
      if (normalized == 'false') {
        return false;
      }
    }
    return null;
  }

  static dynamic _readFromMap(dynamic value, String key) {
    if (value is! Map<String, dynamic>) {
      return null;
    }
    return value[key];
  }
}
