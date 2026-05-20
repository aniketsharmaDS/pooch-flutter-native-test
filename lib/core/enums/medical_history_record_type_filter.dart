enum MedicalHistoryRecordTypeFilter {
  consultation('consultation'),
  vaccination('vaccination'),
  labReport('lab_report'),
  healthRecords('health_record'),
  otherDocuments('document');

  const MedicalHistoryRecordTypeFilter(this.apiValue);

  final String apiValue;
}
