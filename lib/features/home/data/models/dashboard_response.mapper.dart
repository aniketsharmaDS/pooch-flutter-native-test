// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dashboard_response.dart';

class UserItemResponseMapper extends ClassMapperBase<UserItemResponse> {
  UserItemResponseMapper._();

  static UserItemResponseMapper? _instance;
  static UserItemResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserItemResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserItemResponse';

  static String _$id(UserItemResponse v) => v.id;
  static const Field<UserItemResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(UserItemResponse v) => v.name;
  static const Field<UserItemResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$email(UserItemResponse v) => v.email;
  static const Field<UserItemResponse, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<UserItemResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
  };

  static UserItemResponse _instantiate(DecodingData data) {
    return UserItemResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserItemResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserItemResponse>(map);
  }

  static UserItemResponse fromJson(String json) {
    return ensureInitialized().decodeJson<UserItemResponse>(json);
  }
}

mixin UserItemResponseMappable {
  String toJson() {
    return UserItemResponseMapper.ensureInitialized()
        .encodeJson<UserItemResponse>(this as UserItemResponse);
  }

  Map<String, dynamic> toMap() {
    return UserItemResponseMapper.ensureInitialized()
        .encodeMap<UserItemResponse>(this as UserItemResponse);
  }

  UserItemResponseCopyWith<UserItemResponse, UserItemResponse, UserItemResponse>
  get copyWith =>
      _UserItemResponseCopyWithImpl<UserItemResponse, UserItemResponse>(
        this as UserItemResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserItemResponseMapper.ensureInitialized().stringifyValue(
      this as UserItemResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserItemResponseMapper.ensureInitialized().equalsValue(
      this as UserItemResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return UserItemResponseMapper.ensureInitialized().hashValue(
      this as UserItemResponse,
    );
  }
}

extension UserItemResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserItemResponse, $Out> {
  UserItemResponseCopyWith<$R, UserItemResponse, $Out>
  get $asUserItemResponse =>
      $base.as((v, t, t2) => _UserItemResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserItemResponseCopyWith<$R, $In extends UserItemResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? email});
  UserItemResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserItemResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserItemResponse, $Out>
    implements UserItemResponseCopyWith<$R, UserItemResponse, $Out> {
  _UserItemResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserItemResponse> $mapper =
      UserItemResponseMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, String? email}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (email != null) #email: email,
    }),
  );
  @override
  UserItemResponse $make(CopyWithData data) => UserItemResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
  );

  @override
  UserItemResponseCopyWith<$R2, UserItemResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserItemResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartItemResponseMapper extends ClassMapperBase<CartItemResponse> {
  CartItemResponseMapper._();

  static CartItemResponseMapper? _instance;
  static CartItemResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartItemResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CartItemResponse';

  static int _$itemsCount(CartItemResponse v) => v.itemsCount;
  static const Field<CartItemResponse, int> _f$itemsCount = Field(
    'itemsCount',
    _$itemsCount,
    opt: true,
    def: 0,
    hook: SafeIntHook(),
  );
  static double _$totalAmount(CartItemResponse v) => v.totalAmount;
  static const Field<CartItemResponse, double> _f$totalAmount = Field(
    'totalAmount',
    _$totalAmount,
    opt: true,
    def: 0.0,
    hook: SafeDoubleHook(),
  );

  @override
  final MappableFields<CartItemResponse> fields = const {
    #itemsCount: _f$itemsCount,
    #totalAmount: _f$totalAmount,
  };

  static CartItemResponse _instantiate(DecodingData data) {
    return CartItemResponse(
      itemsCount: data.dec(_f$itemsCount),
      totalAmount: data.dec(_f$totalAmount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartItemResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartItemResponse>(map);
  }

  static CartItemResponse fromJson(String json) {
    return ensureInitialized().decodeJson<CartItemResponse>(json);
  }
}

mixin CartItemResponseMappable {
  String toJson() {
    return CartItemResponseMapper.ensureInitialized()
        .encodeJson<CartItemResponse>(this as CartItemResponse);
  }

  Map<String, dynamic> toMap() {
    return CartItemResponseMapper.ensureInitialized()
        .encodeMap<CartItemResponse>(this as CartItemResponse);
  }

  CartItemResponseCopyWith<CartItemResponse, CartItemResponse, CartItemResponse>
  get copyWith =>
      _CartItemResponseCopyWithImpl<CartItemResponse, CartItemResponse>(
        this as CartItemResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartItemResponseMapper.ensureInitialized().stringifyValue(
      this as CartItemResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartItemResponseMapper.ensureInitialized().equalsValue(
      this as CartItemResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return CartItemResponseMapper.ensureInitialized().hashValue(
      this as CartItemResponse,
    );
  }
}

extension CartItemResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CartItemResponse, $Out> {
  CartItemResponseCopyWith<$R, CartItemResponse, $Out>
  get $asCartItemResponse =>
      $base.as((v, t, t2) => _CartItemResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartItemResponseCopyWith<$R, $In extends CartItemResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? itemsCount, double? totalAmount});
  CartItemResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CartItemResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartItemResponse, $Out>
    implements CartItemResponseCopyWith<$R, CartItemResponse, $Out> {
  _CartItemResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartItemResponse> $mapper =
      CartItemResponseMapper.ensureInitialized();
  @override
  $R call({int? itemsCount, double? totalAmount}) => $apply(
    FieldCopyWithData({
      if (itemsCount != null) #itemsCount: itemsCount,
      if (totalAmount != null) #totalAmount: totalAmount,
    }),
  );
  @override
  CartItemResponse $make(CopyWithData data) => CartItemResponse(
    itemsCount: data.get(#itemsCount, or: $value.itemsCount),
    totalAmount: data.get(#totalAmount, or: $value.totalAmount),
  );

  @override
  CartItemResponseCopyWith<$R2, CartItemResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartItemResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetItemResponseMapper extends ClassMapperBase<PetItemResponse> {
  PetItemResponseMapper._();

  static PetItemResponseMapper? _instance;
  static PetItemResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetItemResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetItemResponse';

  static String _$id(PetItemResponse v) => v.id;
  static const Field<PetItemResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$name(PetItemResponse v) => v.name;
  static const Field<PetItemResponse, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$breed(PetItemResponse v) => v.breed;
  static const Field<PetItemResponse, String> _f$breed = Field(
    'breed',
    _$breed,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<PetItemResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #breed: _f$breed,
  };

  static PetItemResponse _instantiate(DecodingData data) {
    return PetItemResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      breed: data.dec(_f$breed),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetItemResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetItemResponse>(map);
  }

  static PetItemResponse fromJson(String json) {
    return ensureInitialized().decodeJson<PetItemResponse>(json);
  }
}

mixin PetItemResponseMappable {
  String toJson() {
    return PetItemResponseMapper.ensureInitialized()
        .encodeJson<PetItemResponse>(this as PetItemResponse);
  }

  Map<String, dynamic> toMap() {
    return PetItemResponseMapper.ensureInitialized().encodeMap<PetItemResponse>(
      this as PetItemResponse,
    );
  }

  PetItemResponseCopyWith<PetItemResponse, PetItemResponse, PetItemResponse>
  get copyWith =>
      _PetItemResponseCopyWithImpl<PetItemResponse, PetItemResponse>(
        this as PetItemResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetItemResponseMapper.ensureInitialized().stringifyValue(
      this as PetItemResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetItemResponseMapper.ensureInitialized().equalsValue(
      this as PetItemResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return PetItemResponseMapper.ensureInitialized().hashValue(
      this as PetItemResponse,
    );
  }
}

extension PetItemResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetItemResponse, $Out> {
  PetItemResponseCopyWith<$R, PetItemResponse, $Out> get $asPetItemResponse =>
      $base.as((v, t, t2) => _PetItemResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetItemResponseCopyWith<$R, $In extends PetItemResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? breed});
  PetItemResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PetItemResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetItemResponse, $Out>
    implements PetItemResponseCopyWith<$R, PetItemResponse, $Out> {
  _PetItemResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetItemResponse> $mapper =
      PetItemResponseMapper.ensureInitialized();
  @override
  $R call({String? id, String? name, String? breed}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (breed != null) #breed: breed,
    }),
  );
  @override
  PetItemResponse $make(CopyWithData data) => PetItemResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    breed: data.get(#breed, or: $value.breed),
  );

  @override
  PetItemResponseCopyWith<$R2, PetItemResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetItemResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppointmentItemResponseMapper
    extends ClassMapperBase<AppointmentItemResponse> {
  AppointmentItemResponseMapper._();

  static AppointmentItemResponseMapper? _instance;
  static AppointmentItemResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppointmentItemResponseMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentItemResponse';

  static String _$id(AppointmentItemResponse v) => v.id;
  static const Field<AppointmentItemResponse, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$petId(AppointmentItemResponse v) => v.petId;
  static const Field<AppointmentItemResponse, String> _f$petId = Field(
    'petId',
    _$petId,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$service(AppointmentItemResponse v) => v.service;
  static const Field<AppointmentItemResponse, String> _f$service = Field(
    'service',
    _$service,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );
  static String _$dateLabel(AppointmentItemResponse v) => v.dateLabel;
  static const Field<AppointmentItemResponse, String> _f$dateLabel = Field(
    'dateLabel',
    _$dateLabel,
    opt: true,
    def: '',
    hook: SafeStringHook(),
  );

  @override
  final MappableFields<AppointmentItemResponse> fields = const {
    #id: _f$id,
    #petId: _f$petId,
    #service: _f$service,
    #dateLabel: _f$dateLabel,
  };

  static AppointmentItemResponse _instantiate(DecodingData data) {
    return AppointmentItemResponse(
      id: data.dec(_f$id),
      petId: data.dec(_f$petId),
      service: data.dec(_f$service),
      dateLabel: data.dec(_f$dateLabel),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentItemResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentItemResponse>(map);
  }

  static AppointmentItemResponse fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentItemResponse>(json);
  }
}

mixin AppointmentItemResponseMappable {
  String toJson() {
    return AppointmentItemResponseMapper.ensureInitialized()
        .encodeJson<AppointmentItemResponse>(this as AppointmentItemResponse);
  }

  Map<String, dynamic> toMap() {
    return AppointmentItemResponseMapper.ensureInitialized()
        .encodeMap<AppointmentItemResponse>(this as AppointmentItemResponse);
  }

  AppointmentItemResponseCopyWith<
    AppointmentItemResponse,
    AppointmentItemResponse,
    AppointmentItemResponse
  >
  get copyWith =>
      _AppointmentItemResponseCopyWithImpl<
        AppointmentItemResponse,
        AppointmentItemResponse
      >(this as AppointmentItemResponse, $identity, $identity);
  @override
  String toString() {
    return AppointmentItemResponseMapper.ensureInitialized().stringifyValue(
      this as AppointmentItemResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentItemResponseMapper.ensureInitialized().equalsValue(
      this as AppointmentItemResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentItemResponseMapper.ensureInitialized().hashValue(
      this as AppointmentItemResponse,
    );
  }
}

extension AppointmentItemResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentItemResponse, $Out> {
  AppointmentItemResponseCopyWith<$R, AppointmentItemResponse, $Out>
  get $asAppointmentItemResponse => $base.as(
    (v, t, t2) => _AppointmentItemResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentItemResponseCopyWith<
  $R,
  $In extends AppointmentItemResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? petId, String? service, String? dateLabel});
  AppointmentItemResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentItemResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentItemResponse, $Out>
    implements
        AppointmentItemResponseCopyWith<$R, AppointmentItemResponse, $Out> {
  _AppointmentItemResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentItemResponse> $mapper =
      AppointmentItemResponseMapper.ensureInitialized();
  @override
  $R call({String? id, String? petId, String? service, String? dateLabel}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (petId != null) #petId: petId,
          if (service != null) #service: service,
          if (dateLabel != null) #dateLabel: dateLabel,
        }),
      );
  @override
  AppointmentItemResponse $make(CopyWithData data) => AppointmentItemResponse(
    id: data.get(#id, or: $value.id),
    petId: data.get(#petId, or: $value.petId),
    service: data.get(#service, or: $value.service),
    dateLabel: data.get(#dateLabel, or: $value.dateLabel),
  );

  @override
  AppointmentItemResponseCopyWith<$R2, AppointmentItemResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentItemResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DashboardResponseMapper extends ClassMapperBase<DashboardResponse> {
  DashboardResponseMapper._();

  static DashboardResponseMapper? _instance;
  static DashboardResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DashboardResponseMapper._());
      UserItemResponseMapper.ensureInitialized();
      CartItemResponseMapper.ensureInitialized();
      PetItemResponseMapper.ensureInitialized();
      AppointmentItemResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DashboardResponse';

  static UserItemResponse _$user(DashboardResponse v) => v.user;
  static const Field<DashboardResponse, UserItemResponse> _f$user = Field(
    'user',
    _$user,
    opt: true,
    def: const UserItemResponse(),
  );
  static CartItemResponse _$cart(DashboardResponse v) => v.cart;
  static const Field<DashboardResponse, CartItemResponse> _f$cart = Field(
    'cart',
    _$cart,
    opt: true,
    def: const CartItemResponse(),
  );
  static List<PetItemResponse> _$pets(DashboardResponse v) => v.pets;
  static const Field<DashboardResponse, List<PetItemResponse>> _f$pets = Field(
    'pets',
    _$pets,
    opt: true,
    def: const <PetItemResponse>[],
  );
  static List<AppointmentItemResponse> _$appointments(DashboardResponse v) =>
      v.appointments;
  static const Field<DashboardResponse, List<AppointmentItemResponse>>
  _f$appointments = Field(
    'appointments',
    _$appointments,
    opt: true,
    def: const <AppointmentItemResponse>[],
  );

  @override
  final MappableFields<DashboardResponse> fields = const {
    #user: _f$user,
    #cart: _f$cart,
    #pets: _f$pets,
    #appointments: _f$appointments,
  };

  static DashboardResponse _instantiate(DecodingData data) {
    return DashboardResponse(
      user: data.dec(_f$user),
      cart: data.dec(_f$cart),
      pets: data.dec(_f$pets),
      appointments: data.dec(_f$appointments),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DashboardResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DashboardResponse>(map);
  }

  static DashboardResponse fromJson(String json) {
    return ensureInitialized().decodeJson<DashboardResponse>(json);
  }
}

mixin DashboardResponseMappable {
  String toJson() {
    return DashboardResponseMapper.ensureInitialized()
        .encodeJson<DashboardResponse>(this as DashboardResponse);
  }

  Map<String, dynamic> toMap() {
    return DashboardResponseMapper.ensureInitialized()
        .encodeMap<DashboardResponse>(this as DashboardResponse);
  }

  DashboardResponseCopyWith<
    DashboardResponse,
    DashboardResponse,
    DashboardResponse
  >
  get copyWith =>
      _DashboardResponseCopyWithImpl<DashboardResponse, DashboardResponse>(
        this as DashboardResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DashboardResponseMapper.ensureInitialized().stringifyValue(
      this as DashboardResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return DashboardResponseMapper.ensureInitialized().equalsValue(
      this as DashboardResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return DashboardResponseMapper.ensureInitialized().hashValue(
      this as DashboardResponse,
    );
  }
}

extension DashboardResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashboardResponse, $Out> {
  DashboardResponseCopyWith<$R, DashboardResponse, $Out>
  get $asDashboardResponse => $base.as(
    (v, t, t2) => _DashboardResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DashboardResponseCopyWith<
  $R,
  $In extends DashboardResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  UserItemResponseCopyWith<$R, UserItemResponse, UserItemResponse> get user;
  CartItemResponseCopyWith<$R, CartItemResponse, CartItemResponse> get cart;
  ListCopyWith<
    $R,
    PetItemResponse,
    PetItemResponseCopyWith<$R, PetItemResponse, PetItemResponse>
  >
  get pets;
  ListCopyWith<
    $R,
    AppointmentItemResponse,
    AppointmentItemResponseCopyWith<
      $R,
      AppointmentItemResponse,
      AppointmentItemResponse
    >
  >
  get appointments;
  $R call({
    UserItemResponse? user,
    CartItemResponse? cart,
    List<PetItemResponse>? pets,
    List<AppointmentItemResponse>? appointments,
  });
  DashboardResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DashboardResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashboardResponse, $Out>
    implements DashboardResponseCopyWith<$R, DashboardResponse, $Out> {
  _DashboardResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashboardResponse> $mapper =
      DashboardResponseMapper.ensureInitialized();
  @override
  UserItemResponseCopyWith<$R, UserItemResponse, UserItemResponse> get user =>
      $value.user.copyWith.$chain((v) => call(user: v));
  @override
  CartItemResponseCopyWith<$R, CartItemResponse, CartItemResponse> get cart =>
      $value.cart.copyWith.$chain((v) => call(cart: v));
  @override
  ListCopyWith<
    $R,
    PetItemResponse,
    PetItemResponseCopyWith<$R, PetItemResponse, PetItemResponse>
  >
  get pets => ListCopyWith(
    $value.pets,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(pets: v),
  );
  @override
  ListCopyWith<
    $R,
    AppointmentItemResponse,
    AppointmentItemResponseCopyWith<
      $R,
      AppointmentItemResponse,
      AppointmentItemResponse
    >
  >
  get appointments => ListCopyWith(
    $value.appointments,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(appointments: v),
  );
  @override
  $R call({
    UserItemResponse? user,
    CartItemResponse? cart,
    List<PetItemResponse>? pets,
    List<AppointmentItemResponse>? appointments,
  }) => $apply(
    FieldCopyWithData({
      if (user != null) #user: user,
      if (cart != null) #cart: cart,
      if (pets != null) #pets: pets,
      if (appointments != null) #appointments: appointments,
    }),
  );
  @override
  DashboardResponse $make(CopyWithData data) => DashboardResponse(
    user: data.get(#user, or: $value.user),
    cart: data.get(#cart, or: $value.cart),
    pets: data.get(#pets, or: $value.pets),
    appointments: data.get(#appointments, or: $value.appointments),
  );

  @override
  DashboardResponseCopyWith<$R2, DashboardResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DashboardResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

