import 'package:equatable/equatable.dart';
import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/insight/data/models/clinic_api_model.dart';

class PopularClinicsPaginationModel {
  const PopularClinicsPaginationModel({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  factory PopularClinicsPaginationModel.fromMap(Map<String, dynamic> map) {
    return PopularClinicsPaginationModel(
      currentPage: ParserUtils.readInt(map['currentPage']),
      pageSize: ParserUtils.readInt(map['pageSize']),
      totalItems: ParserUtils.readInt(map['totalItems']),
      totalPages: ParserUtils.readInt(map['totalPages']),
      hasNextPage: ParserUtils.readBool(map['hasNextPage']),
      hasPrevPage: ParserUtils.readBool(map['hasPrevPage']),
    );
  }
}

class PopularClinicEntry extends Equatable {
  const PopularClinicEntry({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.rank,
    required this.featured,
    required this.status,
    required this.entity,
  });

  final String id;
  final String entityType;
  final String entityId;
  final int rank;
  final bool featured;
  final String status;
  final ClinicApiModel entity;

  factory PopularClinicEntry.fromMap(Map<String, dynamic> map) {
    return PopularClinicEntry(
      id: ParserUtils.readString(map['id']),
      entityType: ParserUtils.readString(map['entityType']),
      entityId: ParserUtils.readString(map['entityId']),
      rank: ParserUtils.readInt(map['rank']),
      featured: ParserUtils.readBool(map['featured']),
      status: ParserUtils.readString(map['status']),
      entity: ClinicApiModel.fromMap(ParserUtils.readMap(map['entity'])),
    );
  }

  @override
  List<Object?> get props => [
    id,
    entityType,
    entityId,
    rank,
    featured,
    status,
    entity,
  ];
}

class PopularClinicsResponseModel {
  const PopularClinicsResponseModel({
    required this.clinics,
    required this.pagination,
  });

  final List<PopularClinicEntry> clinics;
  final PopularClinicsPaginationModel pagination;

  factory PopularClinicsResponseModel.fromMap(Map<String, dynamic> map) {
    return PopularClinicsResponseModel(
      clinics: (map['clinics'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .where((e) => e.isNotEmpty)
          .map(PopularClinicEntry.fromMap)
          .toList(growable: false),
      pagination: PopularClinicsPaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }
}
