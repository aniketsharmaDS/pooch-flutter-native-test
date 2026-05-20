enum TricksAndTrainingContentType { video, training, tip }

extension TricksAndTrainingContentTypeX on TricksAndTrainingContentType {
  String get value {
    switch (this) {
      case TricksAndTrainingContentType.video:
        return 'video';

      case TricksAndTrainingContentType.training:
        return 'training';

      case TricksAndTrainingContentType.tip:
        return 'tip';
    }
  }
}
