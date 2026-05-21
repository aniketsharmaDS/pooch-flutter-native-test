import 'package:equatable/equatable.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object?> get props => [];
}

class FetchShareLinkEvent extends CommunityEvent {
  final String contentId;
  final String contentType; // tip | event

  const FetchShareLinkEvent({
    required this.contentId,
    required this.contentType,
  });

  @override
  List<Object?> get props => [contentId, contentType];
}
