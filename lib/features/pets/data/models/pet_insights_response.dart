import 'package:equatable/equatable.dart';

class PetInsightsResponse extends Equatable {
  const PetInsightsResponse({
    required this.totalPets,
    required this.healthScore,
    required this.nutritionScore,
    required this.weeklyActivityScore,
    required this.lastUpdated,
  });

  final int totalPets;
  final PetInsightScoreResponse healthScore;
  final PetInsightScoreResponse nutritionScore;
  final PetInsightScoreResponse weeklyActivityScore;
  final String lastUpdated;

  factory PetInsightsResponse.fromMap(Map<String, dynamic> map) {
    return PetInsightsResponse(
      totalPets: _int(map['total_pets']),
      healthScore: PetInsightScoreResponse.fromMap(
        map['health_score'] as Map<String, dynamic>? ??
            const <String, dynamic>{},
      ),
      nutritionScore: PetInsightScoreResponse.fromMap(
        map['nutrition_score'] as Map<String, dynamic>? ??
            const <String, dynamic>{},
      ),
      weeklyActivityScore: PetInsightScoreResponse.fromMap(
        map['weekly_activity'] as Map<String, dynamic>? ??
            const <String, dynamic>{},
      ),
      lastUpdated: _string(map['last_updated']),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    totalPets,
    healthScore,
    nutritionScore,
    weeklyActivityScore,
    lastUpdated,
  ];
}

class PetInsightScoreResponse extends Equatable {
  const PetInsightScoreResponse({
    this.score = 0,
    this.percentage = 0,
    this.trend = 0,
    this.trendText = '',
    this.details = '',
    this.goalsMet = '',
  });

  final int score;
  final int percentage;
  final int trend;
  final String trendText;
  final String details;
  final String goalsMet;

  factory PetInsightScoreResponse.fromMap(Map<String, dynamic> map) {
    return PetInsightScoreResponse(
      score: _int(map['score']),
      percentage: _int(map['percentage']),
      trend: _int(map['trend']),
      trendText: _string(map['trend_text']),
      details: _string(map['details']),
      goalsMet: _string(map['goals_met']),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    score,
    percentage,
    trend,
    trendText,
    details,
    goalsMet,
  ];
}

String _string(dynamic value) =>
    value is String ? value : (value ?? '').toString();

int _int(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}
