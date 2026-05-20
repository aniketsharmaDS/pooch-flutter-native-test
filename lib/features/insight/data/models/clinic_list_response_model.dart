import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/insight/data/models/clinic_api_model.dart';

class ClinicListPaginationModel {
  const ClinicListPaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  final int page;
  final int limit;
  final int total;
  final int pages;

  factory ClinicListPaginationModel.fromMap(Map<String, dynamic> map) {
    return ClinicListPaginationModel(
      page: ParserUtils.readInt(map['page']),
      limit: ParserUtils.readInt(map['limit']),
      total: ParserUtils.readInt(map['total']),
      pages: ParserUtils.readInt(map['pages']),
    );
  }
}

class ClinicFilterOptionModel {
  const ClinicFilterOptionModel({required this.value, required this.label});

  final String value;
  final String label;

  factory ClinicFilterOptionModel.fromMap(Map<String, dynamic> map) {
    return ClinicFilterOptionModel(
      value: ParserUtils.readString(map['value']),
      label: ParserUtils.readString(map['label']),
    );
  }
}

class ClinicPriceStatsModel {
  const ClinicPriceStatsModel({required this.min, required this.max});

  final String min;
  final String max;

  factory ClinicPriceStatsModel.fromMap(Map<String, dynamic> map) {
    return ClinicPriceStatsModel(
      min: ParserUtils.readString(map['min']),
      max: ParserUtils.readString(map['max']),
    );
  }
}

class ClinicAvailableFiltersModel {
  const ClinicAvailableFiltersModel({
    required this.cities,
    required this.specializations,
    required this.yearsOfService,
    required this.priceRange,
    required this.priceStats,
    required this.sortOptions,
  });

  final List<String> cities;
  final List<String> specializations;
  final List<ClinicFilterOptionModel> yearsOfService;
  final List<ClinicFilterOptionModel> priceRange;
  final ClinicPriceStatsModel priceStats;
  final List<ClinicFilterOptionModel> sortOptions;

  factory ClinicAvailableFiltersModel.fromMap(Map<String, dynamic> map) {
    return ClinicAvailableFiltersModel(
      cities: ParserUtils.readStringList(map['cities']),
      specializations: ParserUtils.readStringList(map['specializations']),
      yearsOfService: (map['yearsOfService'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .where((e) => e.isNotEmpty)
          .map(ClinicFilterOptionModel.fromMap)
          .toList(growable: false),
      priceRange: (map['priceRange'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .where((e) => e.isNotEmpty)
          .map(ClinicFilterOptionModel.fromMap)
          .toList(growable: false),
      priceStats: ClinicPriceStatsModel.fromMap(
        ParserUtils.readMap(map['priceStats']),
      ),
      sortOptions: (map['sortOptions'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .where((e) => e.isNotEmpty)
          .map(ClinicFilterOptionModel.fromMap)
          .toList(growable: false),
    );
  }
}

class ClinicListResponseModel {
  const ClinicListResponseModel({
    required this.clinics,
    required this.pagination,
    required this.appliedFilters,
    this.availableFilters,
  });

  final List<ClinicApiModel> clinics;
  final ClinicListPaginationModel pagination;
  final Map<String, dynamic> appliedFilters;
  final ClinicAvailableFiltersModel? availableFilters;

  factory ClinicListResponseModel.fromMap(Map<String, dynamic> map) {
    final paginationMap = ParserUtils.readMap(map['pagination']);

    return ClinicListResponseModel(
      clinics: (map['clinics'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ClinicApiModel.fromMap(ParserUtils.readMap(e)))
          .toList(growable: false),
      pagination: ClinicListPaginationModel.fromMap(paginationMap),
      appliedFilters: ParserUtils.readMap(map['appliedFilters']),
      availableFilters: map['availableFilters'] is Map
          ? ClinicAvailableFiltersModel.fromMap(
              ParserUtils.readMap(map['availableFilters']),
            )
          : null,
    );
  }
}
