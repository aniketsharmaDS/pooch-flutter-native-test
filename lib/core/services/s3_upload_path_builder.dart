enum UploadEntityType { users, pets, findVets, community, orders }

enum UploadPurpose {
  profile,
  gallery,
  images,
  kyc,
  vaccination,
  diagnoses,
  labReports,
  currentMedications,
  clinicVisits,
  otherDocuments,
  tipsGuide,
  cancellation,
  findVets,
}

extension UploadEntityTypeX on UploadEntityType {
  String get segment {
    switch (this) {
      case UploadEntityType.users:
        return 'users';
      case UploadEntityType.pets:
        return 'pets';
      case UploadEntityType.findVets:
        return 'findVets';
      case UploadEntityType.orders:
        return 'orders';
      case UploadEntityType.community:
        return 'community';
    }
  }
}

extension UploadPurposeX on UploadPurpose {
  String get segment {
    switch (this) {
      case UploadPurpose.profile:
        return 'profile';
      case UploadPurpose.gallery:
        return 'gallery';
      case UploadPurpose.images:
        return 'images';
      case UploadPurpose.kyc:
        return 'kyc';
      case UploadPurpose.vaccination:
        return 'vaccination';
      case UploadPurpose.diagnoses:
        return 'diagnoses';
      case UploadPurpose.labReports:
        return 'labReports';
      case UploadPurpose.currentMedications:
        return 'currentMedications';
      case UploadPurpose.clinicVisits:
        return 'clinicVisits';
      case UploadPurpose.otherDocuments:
        return 'otherDocuments';
      case UploadPurpose.tipsGuide:
        return 'tipsGuide';
      case UploadPurpose.cancellation:
        return 'cancellation';
      case UploadPurpose.findVets:
        return 'findVets';
    }
  }
}

class S3UploadPathBuilder {
  static String build({
    required UploadEntityType entityType,
    required String userId,
    required UploadPurpose purpose,
  }) {
    final cleanedUserId = userId.trim();
    if (cleanedUserId.isEmpty) {
      throw ArgumentError.value(userId, 'userId', 'userId cannot be empty');
    }

    return '${entityType.segment}/$cleanedUserId/${purpose.segment}';
  }
}
