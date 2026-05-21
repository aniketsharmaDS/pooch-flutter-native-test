import 'package:equatable/equatable.dart';
import 'package:poochcare/features/community/data/models/share_link_response_model.dart';

enum CommunityState { initial, loading, success, failure }

class CommunityDetailsState extends Equatable {
  final dynamic detailsData;
  final CommunityState recordsStatus;
  final ShareLinkResponseData? shareLinkResponseData;
  final String? errorMessage;
  final String? successMessage;

  const CommunityDetailsState({
    this.detailsData,
    this.recordsStatus = CommunityState.initial,
    this.shareLinkResponseData,
    this.errorMessage,
    this.successMessage,
  });

  CommunityDetailsState copyWith({
    dynamic detailsData,
    CommunityState? recordsStatus,
    ShareLinkResponseData? shareLinkResponseData,
    String? errorMessage,
    String? successMessage,
  }) {
    return CommunityDetailsState(
      detailsData: detailsData ?? this.detailsData,
      recordsStatus: recordsStatus ?? this.recordsStatus,
      shareLinkResponseData:
          shareLinkResponseData ?? this.shareLinkResponseData,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    detailsData,
    recordsStatus,
    shareLinkResponseData,
    errorMessage,
    successMessage,
  ];
}
