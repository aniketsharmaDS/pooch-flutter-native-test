import 'package:poochcare/core/utils/parser_utils.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_breed_model.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_carousel_model.dart';
import 'package:poochcare/features/tricks_and_trainings/data/models/tricks_and_training_session_step_model.dart';

class TricksAndTrainingContentModel {
  final String id;
  final String contentType;
  final String level;
  final String petType;

  final int minAgeDays;
  final int maxAgeDays;

  final String title;
  final String description;
  final String shortDescription;
  final String image;

  final bool isActive;
  final bool isPublished;
  final bool isDeleted;

  final String createdAt;
  final String updatedAt;
  final String status;

  final List<String> breedIds;

  final List<TricksAndTrainingBreedModel> breeds;

  /// Tips
  final List<TricksAndTrainingCarouselModel> carousels;

  /// Videos
  final String thumbnail;
  final String videoUrl;
  final String videoPlatform;
  final int videoDuration;

  /// Trainings
  final String trainingType;
  final int numberOfSteps;
  final String type;
  final int sessionDuration;

  final List<TricksAndTrainingSessionStepModel> sessionSteps;

  const TricksAndTrainingContentModel({
    required this.id,
    required this.contentType,
    required this.level,
    required this.petType,
    required this.minAgeDays,
    required this.maxAgeDays,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.image,
    required this.isActive,
    required this.isPublished,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.breedIds,
    required this.breeds,
    required this.carousels,
    required this.thumbnail,
    required this.videoUrl,
    required this.videoPlatform,
    required this.videoDuration,
    required this.trainingType,
    required this.numberOfSteps,
    required this.type,
    required this.sessionDuration,
    required this.sessionSteps,
  });

  factory TricksAndTrainingContentModel.fromMap(Map<String, dynamic> map) {
    return TricksAndTrainingContentModel(
      id: ParserUtils.readString(map['id']),

      contentType: ParserUtils.readString(map['contentType']),

      level: ParserUtils.readString(map['level']),

      petType: ParserUtils.readString(map['petType']),

      minAgeDays: ParserUtils.readInt(map['minAgeDays']),

      maxAgeDays: ParserUtils.readInt(map['maxAgeDays']),

      title: ParserUtils.readString(map['title']),

      description: ParserUtils.readString(map['description']),

      shortDescription: ParserUtils.readString(map['shortDescription']),

      image: ParserUtils.readString(map['image']),

      isActive: ParserUtils.readBool(map['isActive']),

      isPublished: ParserUtils.readBool(map['isPublished']),

      isDeleted: ParserUtils.readBool(map['isDeleted']),

      createdAt: ParserUtils.readString(map['createdAt']),

      updatedAt: ParserUtils.readString(map['updatedAt']),

      status: ParserUtils.readString(map['status']),

      breedIds: (map['breedIds'] as List? ?? [])
          .map((e) => ParserUtils.readString(e))
          .toList(),

      breeds: (map['breeds'] as List? ?? [])
          .map(
            (e) => TricksAndTrainingBreedModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),

      /// Tips
      carousels: (map['carousels'] as List? ?? [])
          .map(
            (e) =>
                TricksAndTrainingCarouselModel.fromMap(ParserUtils.readMap(e)),
          )
          .toList(),

      /// Videos
      thumbnail: ParserUtils.readString(map['thumbnail']),

      videoUrl: ParserUtils.readString(map['videoUrl']),

      videoPlatform: ParserUtils.readString(map['videoPlatform']),

      videoDuration: ParserUtils.readInt(map['videoDuration']),

      /// Trainings
      trainingType: ParserUtils.readString(map['trainingType']),

      numberOfSteps: ParserUtils.readInt(map['numberOfSteps']),

      type: ParserUtils.readString(map['type']),

      sessionDuration: ParserUtils.readInt(map['sessionDuration']),

      sessionSteps: (map['sessionSteps'] as List? ?? [])
          .map(
            (e) => TricksAndTrainingSessionStepModel.fromMap(
              ParserUtils.readMap(e),
            ),
          )
          .toList(),
    );
  }
}
