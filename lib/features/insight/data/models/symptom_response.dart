// 1. Root Response Model
import 'package:equatable/equatable.dart';
import 'package:poochcare/core/utils/safe_parser_service.dart';

class SymptomResponse {
  final bool success;
  final String message;
  final int status;
  final SymptomData? data;

  SymptomResponse({
    required this.success,
    required this.message,
    required this.status,
    this.data,
  });

  factory SymptomResponse.fromJson(Map<String, dynamic> json) {
    return SymptomResponse(
      success: SafeParserService.parseBool(json['success']),
      message: SafeParserService.parseString(json['message']),
      status: SafeParserService.parseInt(json['status']),
      data: SymptomData.fromJson(SafeParserService.parseMap(json['data'])),
    );
  }
}

// 2. Data Wrapper Model
class SymptomData {
  final List<SymptomType> symptomTypes;

  SymptomData({required this.symptomTypes});

  factory SymptomData.fromJson(Map<String, dynamic> json) {
    return SymptomData(
      symptomTypes: SafeParserService.parseList(
        json['data'],
        fromJson: (item) =>
            SymptomType.fromJson(SafeParserService.parseMap(item)),
      ),
    );
  }
}

// 3. Leaf Data Model
class SymptomType extends Equatable {
  final String id;
  final String title;
  final String description;
  final String btnText;
  final String imageUrl;
  final int order;

  const SymptomType({
    required this.id,
    required this.title,
    required this.description,
    required this.btnText,
    required this.imageUrl,
    required this.order,
  });

  factory SymptomType.fromJson(Map<String, dynamic> json) {
    return SymptomType(
      btnText: SafeParserService.parseString(json['btnText']),
      description: SafeParserService.parseString(json['description']),
      id: SafeParserService.parseString(json['id']),
      imageUrl: SafeParserService.parseString(json['imageUrl']),
      order: SafeParserService.parseInt(json['order']),
      title: SafeParserService.parseString(json['title']),
    );
  }

  @override
  List<Object?> get props => [btnText, description, id, imageUrl, order, title];
}
