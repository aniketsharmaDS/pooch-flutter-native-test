import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

part 'dashboard_response.mapper.dart';

@MappableClass()
class UserItemResponse with UserItemResponseMappable {
  const UserItemResponse({this.id = '', this.name = '', this.email = ''});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String email;
}

@MappableClass()
class CartItemResponse with CartItemResponseMappable {
  const CartItemResponse({this.itemsCount = 0, this.totalAmount = 0.0});

  @MappableField(hook: SafeIntHook())
  final int itemsCount;

  @MappableField(hook: SafeDoubleHook())
  final double totalAmount;
}

@MappableClass()
class PetItemResponse with PetItemResponseMappable {
  const PetItemResponse({this.id = '', this.name = '', this.breed = ''});

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String name;

  @MappableField(hook: SafeStringHook())
  final String breed;
}

@MappableClass()
class AppointmentItemResponse with AppointmentItemResponseMappable {
  const AppointmentItemResponse({
    this.id = '',
    this.petId = '',
    this.service = '',
    this.dateLabel = '',
  });

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String petId;

  @MappableField(hook: SafeStringHook())
  final String service;

  @MappableField(hook: SafeStringHook())
  final String dateLabel;
}

@MappableClass()
class DashboardResponse with DashboardResponseMappable {
  const DashboardResponse({
    this.user = const UserItemResponse(),
    this.cart = const CartItemResponse(),
    this.pets = const <PetItemResponse>[],
    this.appointments = const <AppointmentItemResponse>[],
  });

  final UserItemResponse user;
  final CartItemResponse cart;
  final List<PetItemResponse> pets;
  final List<AppointmentItemResponse> appointments;
}
