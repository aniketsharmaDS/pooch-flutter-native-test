import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'pet_response.mapper.dart';

@MappableClass()
class PetResponse with PetResponseMappable {
  const PetResponse({this.id = '', this.name = '', this.breed = ''});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String breed;
}
