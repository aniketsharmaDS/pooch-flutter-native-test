import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'invitation_decision_response.mapper.dart';

@MappableClass()
class InvitationDecisionResponse with InvitationDecisionResponseMappable {
  const InvitationDecisionResponse({
    this.invitationId = '',
    this.parentGroupId = '',
    this.role = '',
    this.acceptedAt = '',
    this.rejectedAt = '',
  });

  @MappableField(hook: SafeStringHook())
  final String invitationId;

  @MappableField(hook: SafeStringHook())
  final String parentGroupId;

  @MappableField(hook: SafeStringHook())
  final String role;

  @MappableField(hook: SafeStringHook())
  final String acceptedAt;

  @MappableField(hook: SafeStringHook())
  final String rejectedAt;
}
