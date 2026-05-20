import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'tips_category_model.mapper.dart';

@MappableClass()
class TipsCategoryModel with TipsCategoryModelMappable {
  const TipsCategoryModel({this.id = '', this.name = '', this.nameAr});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  final String? nameAr;
}
