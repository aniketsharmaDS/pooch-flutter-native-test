class FindVetForm {
  final List<String> symptoms;
  final String duration;
  final String currentMedication;
  final String additionalNotes;
  final List<UploadedDocument> uploadedDocuments;

  const FindVetForm({
    this.symptoms = const [],
    this.duration = '',
    this.currentMedication = '',
    this.additionalNotes = '',
    this.uploadedDocuments = const [],
  });

  FindVetForm copyWith({
    List<String>? symptoms,
    String? duration,
    String? currentMedication,
    String? additionalNotes,
    List<String>? uploadedPhotos,
    List<UploadedDocument>? uploadedDocuments,
  }) {
    return FindVetForm(
      symptoms: symptoms ?? this.symptoms,
      duration: duration ?? this.duration,
      currentMedication: currentMedication ?? this.currentMedication,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      uploadedDocuments: uploadedDocuments ?? this.uploadedDocuments,
    );
  }
}

class UploadedDocument {
  final String id;
  final String fileName;
  final String url;
  final String type;
  final String fileSize;

  const UploadedDocument({
    required this.id,
    required this.fileName,
    required this.url,
    required this.type,
    required this.fileSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'url': url,
      'type': type,
      'fileSize': fileSize,
    };
  }
}

class FindVetFormMapper {
  static Map<String, dynamic> toRequest(FindVetForm form) {
    return {
      'symptoms': form.symptoms.join(','), // "Pain,Coughing"
      'duration': form.duration,
      'medication': form.currentMedication,
      'notes': form.additionalNotes,
      'documents': form.uploadedDocuments.map((e) => e.toJson()).toList(),
    };
  }
}
