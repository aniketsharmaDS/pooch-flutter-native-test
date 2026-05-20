import 'package:equatable/equatable.dart';

class VideoItem extends Equatable {
  const VideoItem({
    required this.id,
    required this.title,
    required this.durationLabel,
    required this.thumbnailUrl,
  });

  final String id;
  final String title;
  final String durationLabel;
  final String thumbnailUrl;

  VideoItem copyWith({
    String? id,
    String? title,
    String? durationLabel,
    String? thumbnailUrl,
  }) {
    return VideoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      durationLabel: durationLabel ?? this.durationLabel,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  @override
  List<Object> get props => <Object>[id, title, durationLabel, thumbnailUrl];
}
