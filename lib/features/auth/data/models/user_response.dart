import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'user_response.mapper.dart';

@MappableClass()
class UserResponse with UserResponseMappable {
  const UserResponse({this.id = '', this.name = '', this.email = ''});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String email;
}
