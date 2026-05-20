class MedicalHistoryRecord {
  const MedicalHistoryRecord({
    required this.id,
    required this.recordId,
    required this.appointmentId,
    required this.recordType,
    required this.title,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText,
    this.documents = const <MedicalHistoryRecordDocument>[],
  });

  final String id;
  final String recordId;
  final String appointmentId;
  final String recordType;
  final String title;
  final String primaryText;
  final String secondaryText;
  final String tertiaryText;
  final List<MedicalHistoryRecordDocument> documents;
}

class MedicalHistoryRecordDocument {
  const MedicalHistoryRecordDocument({
    required this.fileName,
    required this.fileType,
    this.fileSize = '',
    this.url,
  });

  final String fileName;
  final String fileType;
  final String fileSize;
  final String? url;
}

class PaginatedMedicalHistoryRecords {
  const PaginatedMedicalHistoryRecords({
    required this.records,
    required this.hasMore,
  });

  final List<MedicalHistoryRecord> records;
  final bool hasMore;
}
