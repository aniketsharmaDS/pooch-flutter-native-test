import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'save_house_details_response.mapper.dart';

@MappableClass()
class SaveHouseDetailsResponse with SaveHouseDetailsResponseMappable {
  const SaveHouseDetailsResponse({
    this.parentGroup,
    this.onboardingCompleted = false,
  });

  final ParentGroupResponse? parentGroup;

  @MappableField(hook: SafeBoolHook())
  final bool onboardingCompleted;
}

@MappableClass()
class ParentGroupResponse with ParentGroupResponseMappable {
  const ParentGroupResponse({
    this.id = '',
    this.houseName = '',
    this.parentName = '',
    this.createdBy = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.deletedAt = '',
    this.createdByLegacy = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String houseName;

  @MappableField(hook: SafeStringHook())
  final String parentName;

  @MappableField(hook: SafeStringHook())
  final String createdBy;

  @MappableField(hook: SafeStringHook())
  final String createdAt;

  @MappableField(hook: SafeStringHook())
  final String updatedAt;

  @MappableField(hook: SafeStringHook())
  final String deletedAt;

  @MappableField(key: 'created_by', hook: SafeStringHook())
  final String createdByLegacy;
}
