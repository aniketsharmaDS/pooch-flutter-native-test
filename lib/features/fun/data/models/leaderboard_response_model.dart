import 'package:poochcare/core/utils/parser_utils.dart';

class LeaderboardUserModel {
  const LeaderboardUserModel({
    required this.rank,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.profilePicture,
    required this.points,
    required this.joinedAt,
  });

  final int rank;
  final String userId;
  final String name;
  final String? email;
  final String? phone;
  final String? country;
  final String? profilePicture;
  final int points;
  final String joinedAt;

  factory LeaderboardUserModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardUserModel(
      rank: ParserUtils.readInt(map['rank']),
      userId: ParserUtils.readString(map['userId']),
      name: ParserUtils.readString(map['name']),
      email: ParserUtils.readNullableString(map['email']),
      phone: ParserUtils.readNullableString(map['phone']),
      country: ParserUtils.readNullableString(map['country']),
      profilePicture: ParserUtils.readNullableString(map['profilePicture']),
      points: ParserUtils.readInt(map['points']),
      joinedAt: ParserUtils.readString(map['joinedAt']),
    );
  }
}

class LeaderboardPaginationModel {
  const LeaderboardPaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.totalRankedUsers,
  });

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final int totalRankedUsers;

  factory LeaderboardPaginationModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardPaginationModel(
      currentPage: ParserUtils.readInt(map['currentPage']),
      totalPages: ParserUtils.readInt(map['totalPages']),
      totalItems: ParserUtils.readInt(map['totalItems']),
      itemsPerPage: ParserUtils.readInt(map['itemsPerPage']),
      totalRankedUsers: ParserUtils.readInt(map['totalRankedUsers']),
    );
  }
}

class LeaderboardResponseModel {
  const LeaderboardResponseModel({
    required this.leaderboard,
    required this.pagination,
  });

  final List<LeaderboardUserModel> leaderboard;
  final LeaderboardPaginationModel pagination;

  factory LeaderboardResponseModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardResponseModel(
      leaderboard: (map['leaderboard'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .map(LeaderboardUserModel.fromMap)
          .toList(growable: false),
      pagination: LeaderboardPaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }
}
