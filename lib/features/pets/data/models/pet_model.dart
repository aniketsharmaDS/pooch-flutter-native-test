import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'pet_model.mapper.dart';

@MappableClass()
class PetModel with PetModelMappable {
  const PetModel({
    this.profilePicture,
    this.bcsScore,
    required this.name,
    required this.type,
    required this.breedId,
    required this.gender,
    required this.dob,
    required this.size,
    required this.weight,
    required this.height,
    required this.heightUnit,
    required this.weightUnit,
    this.healthInfo,
  });

  @MappableField(hook: SafeStringHook())
  final String? profilePicture;

  @MappableField(hook: SafeIntHook())
  final int? bcsScore;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String type;

  @MappableField(hook: SafeStringHook())
  final String breedId;

  @MappableField(hook: SafeStringHook())
  final String gender;

  @MappableField(hook: SafeStringHook())
  final String dob;

  @MappableField(hook: SafeStringHook())
  final String size;

  @MappableField(hook: SafeDoubleHook())
  final double weight;

  @MappableField(hook: SafeDoubleHook())
  final double height;

  @MappableField(hook: SafeStringHook())
  final String heightUnit;

  @MappableField(hook: SafeStringHook())
  final String weightUnit;

  @MappableField(hook: SafeStringHook())
  final String? healthInfo;
}
