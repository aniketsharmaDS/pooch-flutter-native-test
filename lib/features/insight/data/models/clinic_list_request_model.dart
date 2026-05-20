import 'package:equatable/equatable.dart';
import 'package:poochcare/core/utils/parser_utils.dart';

class ClinicListRequestModel extends Equatable {
  const ClinicListRequestModel({
    this.city = const [],
    this.search,
    this.specializations = const [],
    this.symptoms = const <String>[],
    this.yearsOfService = const <String>[],
    this.priceRange = const <String>[],
    this.sort,
    this.page = 1,
    this.limit = 10,
  });

  final List<String>? city;
  final String? search;
  final List<String>? specializations;
  final List<String> symptoms;
  final List<String>? yearsOfService;
  final List<String>? priceRange;
  final String? sort;
  final int page;
  final int limit;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (ParserUtils.readString(city).isNotEmpty) 'city': city,
      if (ParserUtils.readString(search).isNotEmpty) 'search': search,
      if ((specializations ?? []).isNotEmpty)
        'specializations': specializations,
      if (symptoms.isNotEmpty) 'symptoms': symptoms,
      if ((yearsOfService ?? []).isNotEmpty) 'yearsOfService': yearsOfService,
      if ((priceRange ?? []).isNotEmpty) 'priceRange': priceRange,
      if (ParserUtils.readString(sort).isNotEmpty) 'sort': sort,
      'page': page,
      'limit': limit,
    };
  }

  @override
  List<Object?> get props => [
    city,
    search,
    specializations,
    symptoms,
    yearsOfService,
    priceRange,
    sort,
    page,
    limit,
  ];
}
