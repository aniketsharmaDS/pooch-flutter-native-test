import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'product_response.mapper.dart';

@MappableClass()
class ProductResponse with ProductResponseMappable {
  const ProductResponse({this.id = '', this.name = '', this.price = 0.0});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeDoubleHook())
  final double price;
}
