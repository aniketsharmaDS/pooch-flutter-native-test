import 'package:dio/dio.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/features/invites/data/models/invitation_decision_api_result.dart';
import 'package:poochcare/features/invites/data/models/invitation_decision_response.dart';
import 'package:poochcare/features/invites/data/models/invitations_overview_response.dart';
import 'package:poochcare/features/invites/data/models/invite_action_api_result.dart';
import 'package:poochcare/features/invites/data/models/invite_share_api_result.dart';
import 'package:poochcare/features/invites/data/models/invite_share_response.dart';
import 'package:poochcare/features/invites/data/models/latest_sent_invites_api_result.dart';
import 'package:poochcare/features/invites/data/models/latest_sent_invites_response.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_filter.dart';
import 'package:poochcare/features/invites/domain/models/invite_status_filter.dart';

class InviteApiService {
  const InviteApiService(this._dio);

  final Dio _dio;

  static const String _parentGroupsBasePath = '/rbac-parent-groups';
  static const String _myInvitationsPath = '/rbac-parent-groups/my-invitations';
  static const String _myNetworkInvitesPath =
      '/rbac-parent-groups/my-network-invites';
  static const String _latestSentInvitesPath =
      '/rbac-parent-groups/latest-sent-invites';
  static const String _invitationsBasePath = '/rbac-parent-groups/invitations';

  Future<InviteShareApiResult> shareParentGroupInvite({
    required String parentGroupId,
    required String targetUserEmailOrPhone,
    required String role,
    String? countryCode,
    String? nickname,
  }) async {
    try {
      final String normalizedParentGroupId = parentGroupId.trim();
      final String normalizedTarget = targetUserEmailOrPhone.trim();
      final String normalizedRole = role.trim();
      final String normalizedCountryCode = (countryCode ?? '').trim();

      final Response<dynamic> response = await _dio.post<dynamic>(
        '$_parentGroupsBasePath/$normalizedParentGroupId/share',
        data: <String, dynamic>{
          'targetUserEmailOrPhone': normalizedTarget,
          'role': normalizedRole,
          'countryCode': normalizedCountryCode.isEmpty
              ? null
              : normalizedCountryCode,
          if ((nickname ?? '').trim().isNotEmpty) 'nickname': nickname,
        },
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to send invitation',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return InviteShareApiResult(
        data: InviteShareResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<InvitationsOverviewResponse> getMyInvitations({
    required InviteListFilter filter,
    InviteStatusFilter? status,
    int? page,
  }) async {
    try {
      final queryParameters = _buildInvitesQuery(
        filter: filter,
        status: status,
        page: page,
      );
      final Response<dynamic> response = await _dio.get<dynamic>(
        _myInvitationsPath,
        queryParameters: queryParameters.isEmpty ? null : queryParameters,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch invitations',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return InvitationsOverviewResponseMapper.fromMap(payload);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<InvitationsOverviewResponse> getMyNetworkInvites({
    required InviteListFilter filter,
    InviteStatusFilter? status,
    int? page,
  }) async {
    try {
      final queryParameters = _buildInvitesQuery(
        filter: filter,
        status: status,
        page: page,
      );
      final Response<dynamic> response = await _dio.get<dynamic>(
        _myNetworkInvitesPath,
        queryParameters: queryParameters.isEmpty ? null : queryParameters,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch invitations',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return InvitationsOverviewResponseMapper.fromMap(payload);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<LatestSentInvitesApiResult> getLatestSentInvites() async {
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        _latestSentInvitesPath,
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to fetch latest invitations',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body['data'] ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return LatestSentInvitesApiResult(
        data: LatestSentInvitesResponse.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Map<String, dynamic> _buildInvitesQuery({
    required InviteListFilter filter,
    InviteStatusFilter? status,
    int? page,
  }) {
    final query = <String, dynamic>{};
    final type = filter.toQueryValue();
    if (type != null && type.isNotEmpty) {
      query['type'] = type;
    }
    if (status != null) {
      query['status'] = status.toQueryValue();
    }
    if (page != null) {
      query['page'] = page;
    }
    return query;
  }

  Future<InviteActionApiResult> removeInvitation({
    required String parentGroupId,
    required String invitationId,
  }) async {
    return _deleteInvitation(
      parentGroupId: parentGroupId,
      invitationId: invitationId,
    );
  }

  Future<InviteActionApiResult> sendReminder({
    required String invitationId,
  }) async {
    try {
      final String normalizedInvitationId = invitationId.trim();

      final Response<dynamic> response = await _dio.post<dynamic>(
        '$_invitationsBasePath/$normalizedInvitationId/send-reminder',
      );

      return _parseActionResponse(response);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<InviteActionApiResult> removeMemberAccess({
    required String parentGroupId,
    required String targetUserId,
  }) async {
    try {
      final String normalizedGroupId = parentGroupId.trim();
      final String normalizedUserId = targetUserId.trim();

      final Response<dynamic> response = await _dio.delete<dynamic>(
        '$_parentGroupsBasePath/$normalizedGroupId/members/$normalizedUserId/remove',
      );

      return _parseActionResponse(response);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<InvitationDecisionApiResult> acceptInvitation({
    required String invitationId,
  }) async {
    return _decisionInvitation(invitationId: invitationId, action: 'accept');
  }

  Future<InviteActionApiResult> acceptInvitationByCode({
    required String invitationCode,
    String? email,
  }) async {
    try {
      final String normalizedInvitationCode = invitationCode.trim();
      final String normalizedEmail = (email ?? '').trim();

      final Response<dynamic> response = await _dio.post<dynamic>(
        '$_invitationsBasePath/accept-by-code',
        data: <String, dynamic>{
          'invitationCode': normalizedInvitationCode,
          'email': normalizedEmail.isEmpty ? null : normalizedEmail,
        },
      );

      return _parseActionResponse(response);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<InvitationDecisionApiResult> rejectInvitation({
    required String invitationId,
  }) async {
    return _decisionInvitation(invitationId: invitationId, action: 'reject');
  }

  Future<InviteActionApiResult> leaveParentGroup({
    required String parentGroupId,
    required String invitationId,
  }) async {
    try {
      final String normalizedGroupId = parentGroupId.trim();
      final String normalizedInvitationId = invitationId.trim();

      final Response<dynamic> response = await _dio.post<dynamic>(
        '$_parentGroupsBasePath/$normalizedGroupId/leave/$normalizedInvitationId',
      );
      return _parseActionResponse(response);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<InviteActionApiResult> _deleteInvitation({
    required String parentGroupId,
    required String invitationId,
  }) async {
    try {
      final String normalizedGroupId = parentGroupId.trim();
      final String normalizedInvitationId = invitationId.trim();

      final Response<dynamic> response = await _dio.delete<dynamic>(
        '$_parentGroupsBasePath/$normalizedGroupId/invitations/$normalizedInvitationId',
      );

      return _parseActionResponse(response);
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  Future<InvitationDecisionApiResult> _decisionInvitation({
    required String invitationId,
    required String action,
  }) async {
    try {
      final String normalizedInvitationId = invitationId.trim();

      final Response<dynamic> response = await _dio.post<dynamic>(
        '$_invitationsBasePath/$normalizedInvitationId/$action',
      );

      final dynamic body = response.data;
      if (body is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      final ApiResponse? envelope =
          body.containsKey('success') && body.containsKey('data')
          ? ApiResponseMapper.fromMap(body)
          : null;

      if (envelope != null && !envelope.success) {
        throw ApiException(
          envelope.message.isNotEmpty
              ? envelope.message
              : 'Unable to update invitation',
          code: 'API_ERROR',
          statusCode: envelope.status,
        );
      }

      final dynamic payload = envelope?.data ?? body;
      if (payload is! Map<String, dynamic>) {
        throw const ApiException('Invalid server response', statusCode: 500);
      }

      return InvitationDecisionApiResult(
        data: InvitationDecisionResponseMapper.fromMap(payload),
        message: envelope?.message ?? '',
      );
    } on DioException catch (error) {
      throw _mapDioError(error);
    }
  }

  InviteActionApiResult _parseActionResponse(Response<dynamic> response) {
    final dynamic body = response.data;
    ApiResponse? envelope;
    if (body is Map<String, dynamic> && body.containsKey('success')) {
      envelope = ApiResponseMapper.fromMap(body);
    }

    final bool success = envelope?.success ?? true;
    if (!success) {
      throw ApiException(
        envelope?.message.isNotEmpty == true
            ? envelope!.message
            : 'Unable to update invitation',
        code: 'API_ERROR',
        statusCode: envelope?.status ?? response.statusCode ?? 0,
      );
    }

    return InviteActionApiResult(
      success: success,
      status: envelope?.status ?? response.statusCode ?? 0,
      message: envelope?.message ?? '',
    );
  }

  ApiException _mapDioError(DioException error) {
    final int statusCode = error.response?.statusCode ?? 0;
    final dynamic responseData = error.response?.data;

    if (responseData is Map<String, dynamic>) {
      final String? message = responseData['message'] as String?;
      final String? code = responseData['code'] as String?;
      if (message != null && message.isNotEmpty) {
        return ApiException(
          message,
          code: code ?? 'API_ERROR',
          statusCode: statusCode,
        );
      }
    }

    if (statusCode == 401) {
      return const ApiException(
        'Unauthorized. Please login again.',
        code: 'UNAUTHORIZED',
        statusCode: 401,
      );
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const ApiException(
        'Request timed out. Please try again.',
        code: 'TIMEOUT',
        statusCode: 408,
      );
    }

    if (error.type == DioExceptionType.connectionError) {
      return const ApiException('Something went wrong', code: 'NO_INTERNET');
    }

    return ApiException(
      'Something went wrong. Please try again.',
      code: 'API_ERROR',
      statusCode: statusCode,
    );
  }
}
