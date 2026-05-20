import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'api_response.mapper.dart';

@MappableClass()
class ApiResponse with ApiResponseMappable {
  const ApiResponse({
    this.success = false,
    this.message = '',
    this.status = 0,
    this.data,
  });

  @MappableField(hook: SafeBoolHook())
  final bool success;

  @MappableField(hook: SafeStringHook())
  final String message;

  @MappableField(hook: SafeIntHook())
  final int status;

  final dynamic data;
}
