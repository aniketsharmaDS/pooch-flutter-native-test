import 'package:poochcare/core/utils/parser_utils.dart';

class ExpensePaginationModel {
  final int currentPage;

  final int pageSize;

  final int totalPages;

  final int totalItems;

  final bool hasNextPage;

  final bool hasPrevPage;

  const ExpensePaginationModel({
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.totalItems,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory ExpensePaginationModel.fromMap(Map<String, dynamic> map) {
    return ExpensePaginationModel(
      currentPage: ParserUtils.readInt(map['currentPage']),

      pageSize: ParserUtils.readInt(map['pageSize']),

      totalPages: ParserUtils.readInt(map['totalPages']),

      totalItems: ParserUtils.readInt(map['totalItems']),

      hasNextPage: ParserUtils.readBool(map['hasNextPage']),

      hasPrevPage: ParserUtils.readBool(map['hasPrevPage']),
    );
  }
}
