// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cart_item_model.dart';

class CartItemMapper extends ClassMapperBase<CartItem> {
  CartItemMapper._();

  static CartItemMapper? _instance;
  static CartItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartItemMapper._());
      CartItemProductMapper.ensureInitialized();
      CartItemPricingMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CartItem';

  static String _$id(CartItem v) => v.id;
  static const Field<CartItem, String> _f$id = Field(
    'id',
    _$id,
    hook: SafeStringHook(),
  );
  static String _$userId(CartItem v) => v.userId;
  static const Field<CartItem, String> _f$userId = Field(
    'userId',
    _$userId,
    hook: SafeStringHook(),
  );
  static String? _$productType(CartItem v) => v.productType;
  static const Field<CartItem, String> _f$productType = Field(
    'productType',
    _$productType,
    opt: true,
  );
  static String? _$productId(CartItem v) => v.productId;
  static const Field<CartItem, String> _f$productId = Field(
    'productId',
    _$productId,
    opt: true,
  );
  static int? _$quantity(CartItem v) => v.quantity;
  static const Field<CartItem, int> _f$quantity = Field(
    'quantity',
    _$quantity,
    opt: true,
  );
  static String? _$couponCode(CartItem v) => v.couponCode;
  static const Field<CartItem, String> _f$couponCode = Field(
    'couponCode',
    _$couponCode,
    opt: true,
  );
  static String? _$discountAmount(CartItem v) => v.discountAmount;
  static const Field<CartItem, String> _f$discountAmount = Field(
    'discountAmount',
    _$discountAmount,
    opt: true,
  );
  static String? _$originalPrice(CartItem v) => v.originalPrice;
  static const Field<CartItem, String> _f$originalPrice = Field(
    'originalPrice',
    _$originalPrice,
    opt: true,
  );
  static DateTime? _$createdAt(CartItem v) => v.createdAt;
  static const Field<CartItem, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(CartItem v) => v.updatedAt;
  static const Field<CartItem, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );
  static CartItemProduct? _$product(CartItem v) => v.product;
  static const Field<CartItem, CartItemProduct> _f$product = Field(
    'product',
    _$product,
    opt: true,
  );
  static CartItemPricing? _$pricing(CartItem v) => v.pricing;
  static const Field<CartItem, CartItemPricing> _f$pricing = Field(
    'pricing',
    _$pricing,
    opt: true,
  );

  @override
  final MappableFields<CartItem> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #productType: _f$productType,
    #productId: _f$productId,
    #quantity: _f$quantity,
    #couponCode: _f$couponCode,
    #discountAmount: _f$discountAmount,
    #originalPrice: _f$originalPrice,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #product: _f$product,
    #pricing: _f$pricing,
  };

  static CartItem _instantiate(DecodingData data) {
    return CartItem(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      productType: data.dec(_f$productType),
      productId: data.dec(_f$productId),
      quantity: data.dec(_f$quantity),
      couponCode: data.dec(_f$couponCode),
      discountAmount: data.dec(_f$discountAmount),
      originalPrice: data.dec(_f$originalPrice),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      product: data.dec(_f$product),
      pricing: data.dec(_f$pricing),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartItem>(map);
  }

  static CartItem fromJson(String json) {
    return ensureInitialized().decodeJson<CartItem>(json);
  }
}

mixin CartItemMappable {
  String toJson() {
    return CartItemMapper.ensureInitialized().encodeJson<CartItem>(
      this as CartItem,
    );
  }

  Map<String, dynamic> toMap() {
    return CartItemMapper.ensureInitialized().encodeMap<CartItem>(
      this as CartItem,
    );
  }

  CartItemCopyWith<CartItem, CartItem, CartItem> get copyWith =>
      _CartItemCopyWithImpl<CartItem, CartItem>(
        this as CartItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartItemMapper.ensureInitialized().stringifyValue(this as CartItem);
  }

  @override
  bool operator ==(Object other) {
    return CartItemMapper.ensureInitialized().equalsValue(
      this as CartItem,
      other,
    );
  }

  @override
  int get hashCode {
    return CartItemMapper.ensureInitialized().hashValue(this as CartItem);
  }
}

extension CartItemValueCopy<$R, $Out> on ObjectCopyWith<$R, CartItem, $Out> {
  CartItemCopyWith<$R, CartItem, $Out> get $asCartItem =>
      $base.as((v, t, t2) => _CartItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartItemCopyWith<$R, $In extends CartItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CartItemProductCopyWith<$R, CartItemProduct, CartItemProduct>? get product;
  CartItemPricingCopyWith<$R, CartItemPricing, CartItemPricing>? get pricing;
  $R call({
    String? id,
    String? userId,
    String? productType,
    String? productId,
    int? quantity,
    String? couponCode,
    String? discountAmount,
    String? originalPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
    CartItemProduct? product,
    CartItemPricing? pricing,
  });
  CartItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartItem, $Out>
    implements CartItemCopyWith<$R, CartItem, $Out> {
  _CartItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartItem> $mapper =
      CartItemMapper.ensureInitialized();
  @override
  CartItemProductCopyWith<$R, CartItemProduct, CartItemProduct>? get product =>
      $value.product?.copyWith.$chain((v) => call(product: v));
  @override
  CartItemPricingCopyWith<$R, CartItemPricing, CartItemPricing>? get pricing =>
      $value.pricing?.copyWith.$chain((v) => call(pricing: v));
  @override
  $R call({
    String? id,
    String? userId,
    Object? productType = $none,
    Object? productId = $none,
    Object? quantity = $none,
    Object? couponCode = $none,
    Object? discountAmount = $none,
    Object? originalPrice = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
    Object? product = $none,
    Object? pricing = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (productType != $none) #productType: productType,
      if (productId != $none) #productId: productId,
      if (quantity != $none) #quantity: quantity,
      if (couponCode != $none) #couponCode: couponCode,
      if (discountAmount != $none) #discountAmount: discountAmount,
      if (originalPrice != $none) #originalPrice: originalPrice,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
      if (product != $none) #product: product,
      if (pricing != $none) #pricing: pricing,
    }),
  );
  @override
  CartItem $make(CopyWithData data) => CartItem(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    productType: data.get(#productType, or: $value.productType),
    productId: data.get(#productId, or: $value.productId),
    quantity: data.get(#quantity, or: $value.quantity),
    couponCode: data.get(#couponCode, or: $value.couponCode),
    discountAmount: data.get(#discountAmount, or: $value.discountAmount),
    originalPrice: data.get(#originalPrice, or: $value.originalPrice),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    product: data.get(#product, or: $value.product),
    pricing: data.get(#pricing, or: $value.pricing),
  );

  @override
  CartItemCopyWith<$R2, CartItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartItemProductMapper extends ClassMapperBase<CartItemProduct> {
  CartItemProductMapper._();

  static CartItemProductMapper? _instance;
  static CartItemProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartItemProductMapper._());
      CartItemPetDetailsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CartItemProduct';

  static String? _$id(CartItemProduct v) => v.id;
  static const Field<CartItemProduct, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$productNumber(CartItemProduct v) => v.productNumber;
  static const Field<CartItemProduct, String> _f$productNumber = Field(
    'productNumber',
    _$productNumber,
    opt: true,
  );
  static String? _$vendorId(CartItemProduct v) => v.vendorId;
  static const Field<CartItemProduct, String> _f$vendorId = Field(
    'vendorId',
    _$vendorId,
    opt: true,
  );
  static String? _$warehouseId(CartItemProduct v) => v.warehouseId;
  static const Field<CartItemProduct, String> _f$warehouseId = Field(
    'warehouseId',
    _$warehouseId,
    opt: true,
  );
  static String? _$category(CartItemProduct v) => v.category;
  static const Field<CartItemProduct, String> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static String? _$subcategory(CartItemProduct v) => v.subcategory;
  static const Field<CartItemProduct, String> _f$subcategory = Field(
    'subcategory',
    _$subcategory,
    opt: true,
  );
  static String? _$price(CartItemProduct v) => v.price;
  static const Field<CartItemProduct, String> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static String? _$currencyCode(CartItemProduct v) => v.currencyCode;
  static const Field<CartItemProduct, String> _f$currencyCode = Field(
    'currencyCode',
    _$currencyCode,
    opt: true,
  );
  static String? _$countryCode(CartItemProduct v) => v.countryCode;
  static const Field<CartItemProduct, String> _f$countryCode = Field(
    'countryCode',
    _$countryCode,
    opt: true,
  );
  static int? _$stock(CartItemProduct v) => v.stock;
  static const Field<CartItemProduct, int> _f$stock = Field(
    'stock',
    _$stock,
    opt: true,
  );
  static String? _$status(CartItemProduct v) => v.status;
  static const Field<CartItemProduct, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static List<String>? _$productImages(CartItemProduct v) => v.productImages;
  static const Field<CartItemProduct, List<String>> _f$productImages = Field(
    'productImages',
    _$productImages,
    opt: true,
  );
  static List<String>? _$tileImage(CartItemProduct v) => v.tileImage;
  static const Field<CartItemProduct, List<String>> _f$tileImage = Field(
    'tileImage',
    _$tileImage,
    opt: true,
  );
  static String? _$deliveryType(CartItemProduct v) => v.deliveryType;
  static const Field<CartItemProduct, String> _f$deliveryType = Field(
    'deliveryType',
    _$deliveryType,
    opt: true,
  );
  static String? _$deliveryDistance(CartItemProduct v) => v.deliveryDistance;
  static const Field<CartItemProduct, String> _f$deliveryDistance = Field(
    'deliveryDistance',
    _$deliveryDistance,
    opt: true,
  );
  static String? _$deliveryMethod(CartItemProduct v) => v.deliveryMethod;
  static const Field<CartItemProduct, String> _f$deliveryMethod = Field(
    'deliveryMethod',
    _$deliveryMethod,
    opt: true,
  );
  static String? _$discountType(CartItemProduct v) => v.discountType;
  static const Field<CartItemProduct, String> _f$discountType = Field(
    'discountType',
    _$discountType,
    opt: true,
  );
  static String? _$discountAmount(CartItemProduct v) => v.discountAmount;
  static const Field<CartItemProduct, String> _f$discountAmount = Field(
    'discountAmount',
    _$discountAmount,
    opt: true,
  );
  static bool? _$isActive(CartItemProduct v) => v.isActive;
  static const Field<CartItemProduct, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
  );
  static bool? _$isDeleted(CartItemProduct v) => v.isDeleted;
  static const Field<CartItemProduct, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
  );
  static bool? _$isDraft(CartItemProduct v) => v.isDraft;
  static const Field<CartItemProduct, bool> _f$isDraft = Field(
    'isDraft',
    _$isDraft,
    opt: true,
  );
  static List<String>? _$tags(CartItemProduct v) => v.tags;
  static const Field<CartItemProduct, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
  );
  static int? _$viewCount(CartItemProduct v) => v.viewCount;
  static const Field<CartItemProduct, int> _f$viewCount = Field(
    'viewCount',
    _$viewCount,
    opt: true,
  );
  static DateTime? _$createdAt(CartItemProduct v) => v.createdAt;
  static const Field<CartItemProduct, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(CartItemProduct v) => v.updatedAt;
  static const Field<CartItemProduct, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );
  static CartItemPetDetails? _$petDetails(CartItemProduct v) => v.petDetails;
  static const Field<CartItemProduct, CartItemPetDetails> _f$petDetails = Field(
    'petDetails',
    _$petDetails,
    opt: true,
  );

  @override
  final MappableFields<CartItemProduct> fields = const {
    #id: _f$id,
    #productNumber: _f$productNumber,
    #vendorId: _f$vendorId,
    #warehouseId: _f$warehouseId,
    #category: _f$category,
    #subcategory: _f$subcategory,
    #price: _f$price,
    #currencyCode: _f$currencyCode,
    #countryCode: _f$countryCode,
    #stock: _f$stock,
    #status: _f$status,
    #productImages: _f$productImages,
    #tileImage: _f$tileImage,
    #deliveryType: _f$deliveryType,
    #deliveryDistance: _f$deliveryDistance,
    #deliveryMethod: _f$deliveryMethod,
    #discountType: _f$discountType,
    #discountAmount: _f$discountAmount,
    #isActive: _f$isActive,
    #isDeleted: _f$isDeleted,
    #isDraft: _f$isDraft,
    #tags: _f$tags,
    #viewCount: _f$viewCount,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #petDetails: _f$petDetails,
  };

  static CartItemProduct _instantiate(DecodingData data) {
    return CartItemProduct(
      id: data.dec(_f$id),
      productNumber: data.dec(_f$productNumber),
      vendorId: data.dec(_f$vendorId),
      warehouseId: data.dec(_f$warehouseId),
      category: data.dec(_f$category),
      subcategory: data.dec(_f$subcategory),
      price: data.dec(_f$price),
      currencyCode: data.dec(_f$currencyCode),
      countryCode: data.dec(_f$countryCode),
      stock: data.dec(_f$stock),
      status: data.dec(_f$status),
      productImages: data.dec(_f$productImages),
      tileImage: data.dec(_f$tileImage),
      deliveryType: data.dec(_f$deliveryType),
      deliveryDistance: data.dec(_f$deliveryDistance),
      deliveryMethod: data.dec(_f$deliveryMethod),
      discountType: data.dec(_f$discountType),
      discountAmount: data.dec(_f$discountAmount),
      isActive: data.dec(_f$isActive),
      isDeleted: data.dec(_f$isDeleted),
      isDraft: data.dec(_f$isDraft),
      tags: data.dec(_f$tags),
      viewCount: data.dec(_f$viewCount),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      petDetails: data.dec(_f$petDetails),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartItemProduct fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartItemProduct>(map);
  }

  static CartItemProduct fromJson(String json) {
    return ensureInitialized().decodeJson<CartItemProduct>(json);
  }
}

mixin CartItemProductMappable {
  String toJson() {
    return CartItemProductMapper.ensureInitialized()
        .encodeJson<CartItemProduct>(this as CartItemProduct);
  }

  Map<String, dynamic> toMap() {
    return CartItemProductMapper.ensureInitialized().encodeMap<CartItemProduct>(
      this as CartItemProduct,
    );
  }

  CartItemProductCopyWith<CartItemProduct, CartItemProduct, CartItemProduct>
  get copyWith =>
      _CartItemProductCopyWithImpl<CartItemProduct, CartItemProduct>(
        this as CartItemProduct,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartItemProductMapper.ensureInitialized().stringifyValue(
      this as CartItemProduct,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartItemProductMapper.ensureInitialized().equalsValue(
      this as CartItemProduct,
      other,
    );
  }

  @override
  int get hashCode {
    return CartItemProductMapper.ensureInitialized().hashValue(
      this as CartItemProduct,
    );
  }
}

extension CartItemProductValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CartItemProduct, $Out> {
  CartItemProductCopyWith<$R, CartItemProduct, $Out> get $asCartItemProduct =>
      $base.as((v, t, t2) => _CartItemProductCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartItemProductCopyWith<$R, $In extends CartItemProduct, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get productImages;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tileImage;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tags;
  CartItemPetDetailsCopyWith<$R, CartItemPetDetails, CartItemPetDetails>?
  get petDetails;
  $R call({
    String? id,
    String? productNumber,
    String? vendorId,
    String? warehouseId,
    String? category,
    String? subcategory,
    String? price,
    String? currencyCode,
    String? countryCode,
    int? stock,
    String? status,
    List<String>? productImages,
    List<String>? tileImage,
    String? deliveryType,
    String? deliveryDistance,
    String? deliveryMethod,
    String? discountType,
    String? discountAmount,
    bool? isActive,
    bool? isDeleted,
    bool? isDraft,
    List<String>? tags,
    int? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    CartItemPetDetails? petDetails,
  });
  CartItemProductCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CartItemProductCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartItemProduct, $Out>
    implements CartItemProductCopyWith<$R, CartItemProduct, $Out> {
  _CartItemProductCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartItemProduct> $mapper =
      CartItemProductMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get productImages => $value.productImages != null
      ? ListCopyWith(
          $value.productImages!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(productImages: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tileImage =>
      $value.tileImage != null
      ? ListCopyWith(
          $value.tileImage!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(tileImage: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tags =>
      $value.tags != null
      ? ListCopyWith(
          $value.tags!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(tags: v),
        )
      : null;
  @override
  CartItemPetDetailsCopyWith<$R, CartItemPetDetails, CartItemPetDetails>?
  get petDetails =>
      $value.petDetails?.copyWith.$chain((v) => call(petDetails: v));
  @override
  $R call({
    Object? id = $none,
    Object? productNumber = $none,
    Object? vendorId = $none,
    Object? warehouseId = $none,
    Object? category = $none,
    Object? subcategory = $none,
    Object? price = $none,
    Object? currencyCode = $none,
    Object? countryCode = $none,
    Object? stock = $none,
    Object? status = $none,
    Object? productImages = $none,
    Object? tileImage = $none,
    Object? deliveryType = $none,
    Object? deliveryDistance = $none,
    Object? deliveryMethod = $none,
    Object? discountType = $none,
    Object? discountAmount = $none,
    Object? isActive = $none,
    Object? isDeleted = $none,
    Object? isDraft = $none,
    Object? tags = $none,
    Object? viewCount = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
    Object? petDetails = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (productNumber != $none) #productNumber: productNumber,
      if (vendorId != $none) #vendorId: vendorId,
      if (warehouseId != $none) #warehouseId: warehouseId,
      if (category != $none) #category: category,
      if (subcategory != $none) #subcategory: subcategory,
      if (price != $none) #price: price,
      if (currencyCode != $none) #currencyCode: currencyCode,
      if (countryCode != $none) #countryCode: countryCode,
      if (stock != $none) #stock: stock,
      if (status != $none) #status: status,
      if (productImages != $none) #productImages: productImages,
      if (tileImage != $none) #tileImage: tileImage,
      if (deliveryType != $none) #deliveryType: deliveryType,
      if (deliveryDistance != $none) #deliveryDistance: deliveryDistance,
      if (deliveryMethod != $none) #deliveryMethod: deliveryMethod,
      if (discountType != $none) #discountType: discountType,
      if (discountAmount != $none) #discountAmount: discountAmount,
      if (isActive != $none) #isActive: isActive,
      if (isDeleted != $none) #isDeleted: isDeleted,
      if (isDraft != $none) #isDraft: isDraft,
      if (tags != $none) #tags: tags,
      if (viewCount != $none) #viewCount: viewCount,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
      if (petDetails != $none) #petDetails: petDetails,
    }),
  );
  @override
  CartItemProduct $make(CopyWithData data) => CartItemProduct(
    id: data.get(#id, or: $value.id),
    productNumber: data.get(#productNumber, or: $value.productNumber),
    vendorId: data.get(#vendorId, or: $value.vendorId),
    warehouseId: data.get(#warehouseId, or: $value.warehouseId),
    category: data.get(#category, or: $value.category),
    subcategory: data.get(#subcategory, or: $value.subcategory),
    price: data.get(#price, or: $value.price),
    currencyCode: data.get(#currencyCode, or: $value.currencyCode),
    countryCode: data.get(#countryCode, or: $value.countryCode),
    stock: data.get(#stock, or: $value.stock),
    status: data.get(#status, or: $value.status),
    productImages: data.get(#productImages, or: $value.productImages),
    tileImage: data.get(#tileImage, or: $value.tileImage),
    deliveryType: data.get(#deliveryType, or: $value.deliveryType),
    deliveryDistance: data.get(#deliveryDistance, or: $value.deliveryDistance),
    deliveryMethod: data.get(#deliveryMethod, or: $value.deliveryMethod),
    discountType: data.get(#discountType, or: $value.discountType),
    discountAmount: data.get(#discountAmount, or: $value.discountAmount),
    isActive: data.get(#isActive, or: $value.isActive),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    isDraft: data.get(#isDraft, or: $value.isDraft),
    tags: data.get(#tags, or: $value.tags),
    viewCount: data.get(#viewCount, or: $value.viewCount),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    petDetails: data.get(#petDetails, or: $value.petDetails),
  );

  @override
  CartItemProductCopyWith<$R2, CartItemProduct, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartItemProductCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartItemPetDetailsMapper extends ClassMapperBase<CartItemPetDetails> {
  CartItemPetDetailsMapper._();

  static CartItemPetDetailsMapper? _instance;
  static CartItemPetDetailsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartItemPetDetailsMapper._());
      PetTranslationMapper.ensureInitialized();
      PetBreedInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CartItemPetDetails';

  static String? _$id(CartItemPetDetails v) => v.id;
  static const Field<CartItemPetDetails, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$gender(CartItemPetDetails v) => v.gender;
  static const Field<CartItemPetDetails, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
  );
  static String? _$breedId(CartItemPetDetails v) => v.breedId;
  static const Field<CartItemPetDetails, String> _f$breedId = Field(
    'breedId',
    _$breedId,
    opt: true,
  );
  static DateTime? _$dob(CartItemPetDetails v) => v.dob;
  static const Field<CartItemPetDetails, DateTime> _f$dob = Field(
    'dob',
    _$dob,
    opt: true,
  );
  static String? _$size(CartItemPetDetails v) => v.size;
  static const Field<CartItemPetDetails, String> _f$size = Field(
    'size',
    _$size,
    opt: true,
  );
  static String? _$weight(CartItemPetDetails v) => v.weight;
  static const Field<CartItemPetDetails, String> _f$weight = Field(
    'weight',
    _$weight,
    opt: true,
  );
  static String? _$height(CartItemPetDetails v) => v.height;
  static const Field<CartItemPetDetails, String> _f$height = Field(
    'height',
    _$height,
    opt: true,
  );
  static String? _$heightUnit(CartItemPetDetails v) => v.heightUnit;
  static const Field<CartItemPetDetails, String> _f$heightUnit = Field(
    'heightUnit',
    _$heightUnit,
    opt: true,
  );
  static String? _$weightUnit(CartItemPetDetails v) => v.weightUnit;
  static const Field<CartItemPetDetails, String> _f$weightUnit = Field(
    'weightUnit',
    _$weightUnit,
    opt: true,
  );
  static String? _$priceUnit(CartItemPetDetails v) => v.priceUnit;
  static const Field<CartItemPetDetails, String> _f$priceUnit = Field(
    'priceUnit',
    _$priceUnit,
    opt: true,
  );
  static int? _$bcsScore(CartItemPetDetails v) => v.bcsScore;
  static const Field<CartItemPetDetails, int> _f$bcsScore = Field(
    'bcsScore',
    _$bcsScore,
    opt: true,
  );
  static String? _$lifeStage(CartItemPetDetails v) => v.lifeStage;
  static const Field<CartItemPetDetails, String> _f$lifeStage = Field(
    'lifeStage',
    _$lifeStage,
    opt: true,
  );
  static String? _$energyLevel(CartItemPetDetails v) => v.energyLevel;
  static const Field<CartItemPetDetails, String> _f$energyLevel = Field(
    'energyLevel',
    _$energyLevel,
    opt: true,
  );
  static String? _$groomingNeeds(CartItemPetDetails v) => v.groomingNeeds;
  static const Field<CartItemPetDetails, String> _f$groomingNeeds = Field(
    'groomingNeeds',
    _$groomingNeeds,
    opt: true,
  );
  static String? _$temperament(CartItemPetDetails v) => v.temperament;
  static const Field<CartItemPetDetails, String> _f$temperament = Field(
    'temperament',
    _$temperament,
    opt: true,
  );
  static bool? _$isHypoallergenic(CartItemPetDetails v) => v.isHypoallergenic;
  static const Field<CartItemPetDetails, bool> _f$isHypoallergenic = Field(
    'isHypoallergenic',
    _$isHypoallergenic,
    opt: true,
  );
  static bool? _$isVaccinated(CartItemPetDetails v) => v.isVaccinated;
  static const Field<CartItemPetDetails, bool> _f$isVaccinated = Field(
    'isVaccinated',
    _$isVaccinated,
    opt: true,
  );
  static String? _$allergies(CartItemPetDetails v) => v.allergies;
  static const Field<CartItemPetDetails, String> _f$allergies = Field(
    'allergies',
    _$allergies,
    opt: true,
  );
  static DateTime? _$createdAt(CartItemPetDetails v) => v.createdAt;
  static const Field<CartItemPetDetails, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(CartItemPetDetails v) => v.updatedAt;
  static const Field<CartItemPetDetails, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );
  static List<PetTranslation>? _$translations(CartItemPetDetails v) =>
      v.translations;
  static const Field<CartItemPetDetails, List<PetTranslation>> _f$translations =
      Field('translations', _$translations, opt: true);
  static PetBreedInfo? _$breedInfo(CartItemPetDetails v) => v.breedInfo;
  static const Field<CartItemPetDetails, PetBreedInfo> _f$breedInfo = Field(
    'breedInfo',
    _$breedInfo,
    opt: true,
  );

  @override
  final MappableFields<CartItemPetDetails> fields = const {
    #id: _f$id,
    #gender: _f$gender,
    #breedId: _f$breedId,
    #dob: _f$dob,
    #size: _f$size,
    #weight: _f$weight,
    #height: _f$height,
    #heightUnit: _f$heightUnit,
    #weightUnit: _f$weightUnit,
    #priceUnit: _f$priceUnit,
    #bcsScore: _f$bcsScore,
    #lifeStage: _f$lifeStage,
    #energyLevel: _f$energyLevel,
    #groomingNeeds: _f$groomingNeeds,
    #temperament: _f$temperament,
    #isHypoallergenic: _f$isHypoallergenic,
    #isVaccinated: _f$isVaccinated,
    #allergies: _f$allergies,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #translations: _f$translations,
    #breedInfo: _f$breedInfo,
  };

  static CartItemPetDetails _instantiate(DecodingData data) {
    return CartItemPetDetails(
      id: data.dec(_f$id),
      gender: data.dec(_f$gender),
      breedId: data.dec(_f$breedId),
      dob: data.dec(_f$dob),
      size: data.dec(_f$size),
      weight: data.dec(_f$weight),
      height: data.dec(_f$height),
      heightUnit: data.dec(_f$heightUnit),
      weightUnit: data.dec(_f$weightUnit),
      priceUnit: data.dec(_f$priceUnit),
      bcsScore: data.dec(_f$bcsScore),
      lifeStage: data.dec(_f$lifeStage),
      energyLevel: data.dec(_f$energyLevel),
      groomingNeeds: data.dec(_f$groomingNeeds),
      temperament: data.dec(_f$temperament),
      isHypoallergenic: data.dec(_f$isHypoallergenic),
      isVaccinated: data.dec(_f$isVaccinated),
      allergies: data.dec(_f$allergies),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      translations: data.dec(_f$translations),
      breedInfo: data.dec(_f$breedInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartItemPetDetails fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartItemPetDetails>(map);
  }

  static CartItemPetDetails fromJson(String json) {
    return ensureInitialized().decodeJson<CartItemPetDetails>(json);
  }
}

mixin CartItemPetDetailsMappable {
  String toJson() {
    return CartItemPetDetailsMapper.ensureInitialized()
        .encodeJson<CartItemPetDetails>(this as CartItemPetDetails);
  }

  Map<String, dynamic> toMap() {
    return CartItemPetDetailsMapper.ensureInitialized()
        .encodeMap<CartItemPetDetails>(this as CartItemPetDetails);
  }

  CartItemPetDetailsCopyWith<
    CartItemPetDetails,
    CartItemPetDetails,
    CartItemPetDetails
  >
  get copyWith =>
      _CartItemPetDetailsCopyWithImpl<CartItemPetDetails, CartItemPetDetails>(
        this as CartItemPetDetails,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartItemPetDetailsMapper.ensureInitialized().stringifyValue(
      this as CartItemPetDetails,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartItemPetDetailsMapper.ensureInitialized().equalsValue(
      this as CartItemPetDetails,
      other,
    );
  }

  @override
  int get hashCode {
    return CartItemPetDetailsMapper.ensureInitialized().hashValue(
      this as CartItemPetDetails,
    );
  }
}

extension CartItemPetDetailsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CartItemPetDetails, $Out> {
  CartItemPetDetailsCopyWith<$R, CartItemPetDetails, $Out>
  get $asCartItemPetDetails => $base.as(
    (v, t, t2) => _CartItemPetDetailsCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CartItemPetDetailsCopyWith<
  $R,
  $In extends CartItemPetDetails,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PetTranslation,
    PetTranslationCopyWith<$R, PetTranslation, PetTranslation>
  >?
  get translations;
  PetBreedInfoCopyWith<$R, PetBreedInfo, PetBreedInfo>? get breedInfo;
  $R call({
    String? id,
    String? gender,
    String? breedId,
    DateTime? dob,
    String? size,
    String? weight,
    String? height,
    String? heightUnit,
    String? weightUnit,
    String? priceUnit,
    int? bcsScore,
    String? lifeStage,
    String? energyLevel,
    String? groomingNeeds,
    String? temperament,
    bool? isHypoallergenic,
    bool? isVaccinated,
    String? allergies,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<PetTranslation>? translations,
    PetBreedInfo? breedInfo,
  });
  CartItemPetDetailsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CartItemPetDetailsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartItemPetDetails, $Out>
    implements CartItemPetDetailsCopyWith<$R, CartItemPetDetails, $Out> {
  _CartItemPetDetailsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartItemPetDetails> $mapper =
      CartItemPetDetailsMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PetTranslation,
    PetTranslationCopyWith<$R, PetTranslation, PetTranslation>
  >?
  get translations => $value.translations != null
      ? ListCopyWith(
          $value.translations!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(translations: v),
        )
      : null;
  @override
  PetBreedInfoCopyWith<$R, PetBreedInfo, PetBreedInfo>? get breedInfo =>
      $value.breedInfo?.copyWith.$chain((v) => call(breedInfo: v));
  @override
  $R call({
    Object? id = $none,
    Object? gender = $none,
    Object? breedId = $none,
    Object? dob = $none,
    Object? size = $none,
    Object? weight = $none,
    Object? height = $none,
    Object? heightUnit = $none,
    Object? weightUnit = $none,
    Object? priceUnit = $none,
    Object? bcsScore = $none,
    Object? lifeStage = $none,
    Object? energyLevel = $none,
    Object? groomingNeeds = $none,
    Object? temperament = $none,
    Object? isHypoallergenic = $none,
    Object? isVaccinated = $none,
    Object? allergies = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
    Object? translations = $none,
    Object? breedInfo = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (gender != $none) #gender: gender,
      if (breedId != $none) #breedId: breedId,
      if (dob != $none) #dob: dob,
      if (size != $none) #size: size,
      if (weight != $none) #weight: weight,
      if (height != $none) #height: height,
      if (heightUnit != $none) #heightUnit: heightUnit,
      if (weightUnit != $none) #weightUnit: weightUnit,
      if (priceUnit != $none) #priceUnit: priceUnit,
      if (bcsScore != $none) #bcsScore: bcsScore,
      if (lifeStage != $none) #lifeStage: lifeStage,
      if (energyLevel != $none) #energyLevel: energyLevel,
      if (groomingNeeds != $none) #groomingNeeds: groomingNeeds,
      if (temperament != $none) #temperament: temperament,
      if (isHypoallergenic != $none) #isHypoallergenic: isHypoallergenic,
      if (isVaccinated != $none) #isVaccinated: isVaccinated,
      if (allergies != $none) #allergies: allergies,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
      if (translations != $none) #translations: translations,
      if (breedInfo != $none) #breedInfo: breedInfo,
    }),
  );
  @override
  CartItemPetDetails $make(CopyWithData data) => CartItemPetDetails(
    id: data.get(#id, or: $value.id),
    gender: data.get(#gender, or: $value.gender),
    breedId: data.get(#breedId, or: $value.breedId),
    dob: data.get(#dob, or: $value.dob),
    size: data.get(#size, or: $value.size),
    weight: data.get(#weight, or: $value.weight),
    height: data.get(#height, or: $value.height),
    heightUnit: data.get(#heightUnit, or: $value.heightUnit),
    weightUnit: data.get(#weightUnit, or: $value.weightUnit),
    priceUnit: data.get(#priceUnit, or: $value.priceUnit),
    bcsScore: data.get(#bcsScore, or: $value.bcsScore),
    lifeStage: data.get(#lifeStage, or: $value.lifeStage),
    energyLevel: data.get(#energyLevel, or: $value.energyLevel),
    groomingNeeds: data.get(#groomingNeeds, or: $value.groomingNeeds),
    temperament: data.get(#temperament, or: $value.temperament),
    isHypoallergenic: data.get(#isHypoallergenic, or: $value.isHypoallergenic),
    isVaccinated: data.get(#isVaccinated, or: $value.isVaccinated),
    allergies: data.get(#allergies, or: $value.allergies),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    translations: data.get(#translations, or: $value.translations),
    breedInfo: data.get(#breedInfo, or: $value.breedInfo),
  );

  @override
  CartItemPetDetailsCopyWith<$R2, CartItemPetDetails, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartItemPetDetailsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetTranslationMapper extends ClassMapperBase<PetTranslation> {
  PetTranslationMapper._();

  static PetTranslationMapper? _instance;
  static PetTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetTranslationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetTranslation';

  static int? _$translationId(PetTranslation v) => v.translationId;
  static const Field<PetTranslation, int> _f$translationId = Field(
    'translationId',
    _$translationId,
    opt: true,
  );
  static String? _$productId(PetTranslation v) => v.productId;
  static const Field<PetTranslation, String> _f$productId = Field(
    'productId',
    _$productId,
    opt: true,
  );
  static String? _$langCode(PetTranslation v) => v.langCode;
  static const Field<PetTranslation, String> _f$langCode = Field(
    'langCode',
    _$langCode,
    opt: true,
  );
  static String? _$name(PetTranslation v) => v.name;
  static const Field<PetTranslation, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$description(PetTranslation v) => v.description;
  static const Field<PetTranslation, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static DateTime? _$createdAt(PetTranslation v) => v.createdAt;
  static const Field<PetTranslation, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static DateTime? _$updatedAt(PetTranslation v) => v.updatedAt;
  static const Field<PetTranslation, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<PetTranslation> fields = const {
    #translationId: _f$translationId,
    #productId: _f$productId,
    #langCode: _f$langCode,
    #name: _f$name,
    #description: _f$description,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static PetTranslation _instantiate(DecodingData data) {
    return PetTranslation(
      translationId: data.dec(_f$translationId),
      productId: data.dec(_f$productId),
      langCode: data.dec(_f$langCode),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetTranslation>(map);
  }

  static PetTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<PetTranslation>(json);
  }
}

mixin PetTranslationMappable {
  String toJson() {
    return PetTranslationMapper.ensureInitialized().encodeJson<PetTranslation>(
      this as PetTranslation,
    );
  }

  Map<String, dynamic> toMap() {
    return PetTranslationMapper.ensureInitialized().encodeMap<PetTranslation>(
      this as PetTranslation,
    );
  }

  PetTranslationCopyWith<PetTranslation, PetTranslation, PetTranslation>
  get copyWith => _PetTranslationCopyWithImpl<PetTranslation, PetTranslation>(
    this as PetTranslation,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PetTranslationMapper.ensureInitialized().stringifyValue(
      this as PetTranslation,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetTranslationMapper.ensureInitialized().equalsValue(
      this as PetTranslation,
      other,
    );
  }

  @override
  int get hashCode {
    return PetTranslationMapper.ensureInitialized().hashValue(
      this as PetTranslation,
    );
  }
}

extension PetTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetTranslation, $Out> {
  PetTranslationCopyWith<$R, PetTranslation, $Out> get $asPetTranslation =>
      $base.as((v, t, t2) => _PetTranslationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetTranslationCopyWith<$R, $In extends PetTranslation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? translationId,
    String? productId,
    String? langCode,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  PetTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PetTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetTranslation, $Out>
    implements PetTranslationCopyWith<$R, PetTranslation, $Out> {
  _PetTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetTranslation> $mapper =
      PetTranslationMapper.ensureInitialized();
  @override
  $R call({
    Object? translationId = $none,
    Object? productId = $none,
    Object? langCode = $none,
    Object? name = $none,
    Object? description = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (translationId != $none) #translationId: translationId,
      if (productId != $none) #productId: productId,
      if (langCode != $none) #langCode: langCode,
      if (name != $none) #name: name,
      if (description != $none) #description: description,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  PetTranslation $make(CopyWithData data) => PetTranslation(
    translationId: data.get(#translationId, or: $value.translationId),
    productId: data.get(#productId, or: $value.productId),
    langCode: data.get(#langCode, or: $value.langCode),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  PetTranslationCopyWith<$R2, PetTranslation, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetTranslationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PetBreedInfoMapper extends ClassMapperBase<PetBreedInfo> {
  PetBreedInfoMapper._();

  static PetBreedInfoMapper? _instance;
  static PetBreedInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetBreedInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetBreedInfo';

  static String? _$id(PetBreedInfo v) => v.id;
  static const Field<PetBreedInfo, String> _f$id = Field('id', _$id, opt: true);
  static String? _$breedName(PetBreedInfo v) => v.breedName;
  static const Field<PetBreedInfo, String> _f$breedName = Field(
    'breedName',
    _$breedName,
    opt: true,
  );
  static String? _$petType(PetBreedInfo v) => v.petType;
  static const Field<PetBreedInfo, String> _f$petType = Field(
    'petType',
    _$petType,
    opt: true,
  );
  static String? _$sizeCategory(PetBreedInfo v) => v.sizeCategory;
  static const Field<PetBreedInfo, String> _f$sizeCategory = Field(
    'sizeCategory',
    _$sizeCategory,
    opt: true,
  );
  static String? _$temperament(PetBreedInfo v) => v.temperament;
  static const Field<PetBreedInfo, String> _f$temperament = Field(
    'temperament',
    _$temperament,
    opt: true,
  );
  static String? _$averageWeight(PetBreedInfo v) => v.averageWeight;
  static const Field<PetBreedInfo, String> _f$averageWeight = Field(
    'averageWeight',
    _$averageWeight,
    opt: true,
  );
  static String? _$averageLifespan(PetBreedInfo v) => v.averageLifespan;
  static const Field<PetBreedInfo, String> _f$averageLifespan = Field(
    'averageLifespan',
    _$averageLifespan,
    opt: true,
  );

  @override
  final MappableFields<PetBreedInfo> fields = const {
    #id: _f$id,
    #breedName: _f$breedName,
    #petType: _f$petType,
    #sizeCategory: _f$sizeCategory,
    #temperament: _f$temperament,
    #averageWeight: _f$averageWeight,
    #averageLifespan: _f$averageLifespan,
  };

  static PetBreedInfo _instantiate(DecodingData data) {
    return PetBreedInfo(
      id: data.dec(_f$id),
      breedName: data.dec(_f$breedName),
      petType: data.dec(_f$petType),
      sizeCategory: data.dec(_f$sizeCategory),
      temperament: data.dec(_f$temperament),
      averageWeight: data.dec(_f$averageWeight),
      averageLifespan: data.dec(_f$averageLifespan),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetBreedInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetBreedInfo>(map);
  }

  static PetBreedInfo fromJson(String json) {
    return ensureInitialized().decodeJson<PetBreedInfo>(json);
  }
}

mixin PetBreedInfoMappable {
  String toJson() {
    return PetBreedInfoMapper.ensureInitialized().encodeJson<PetBreedInfo>(
      this as PetBreedInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return PetBreedInfoMapper.ensureInitialized().encodeMap<PetBreedInfo>(
      this as PetBreedInfo,
    );
  }

  PetBreedInfoCopyWith<PetBreedInfo, PetBreedInfo, PetBreedInfo> get copyWith =>
      _PetBreedInfoCopyWithImpl<PetBreedInfo, PetBreedInfo>(
        this as PetBreedInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetBreedInfoMapper.ensureInitialized().stringifyValue(
      this as PetBreedInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetBreedInfoMapper.ensureInitialized().equalsValue(
      this as PetBreedInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return PetBreedInfoMapper.ensureInitialized().hashValue(
      this as PetBreedInfo,
    );
  }
}

extension PetBreedInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetBreedInfo, $Out> {
  PetBreedInfoCopyWith<$R, PetBreedInfo, $Out> get $asPetBreedInfo =>
      $base.as((v, t, t2) => _PetBreedInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetBreedInfoCopyWith<$R, $In extends PetBreedInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? breedName,
    String? petType,
    String? sizeCategory,
    String? temperament,
    String? averageWeight,
    String? averageLifespan,
  });
  PetBreedInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetBreedInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetBreedInfo, $Out>
    implements PetBreedInfoCopyWith<$R, PetBreedInfo, $Out> {
  _PetBreedInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetBreedInfo> $mapper =
      PetBreedInfoMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? breedName = $none,
    Object? petType = $none,
    Object? sizeCategory = $none,
    Object? temperament = $none,
    Object? averageWeight = $none,
    Object? averageLifespan = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (breedName != $none) #breedName: breedName,
      if (petType != $none) #petType: petType,
      if (sizeCategory != $none) #sizeCategory: sizeCategory,
      if (temperament != $none) #temperament: temperament,
      if (averageWeight != $none) #averageWeight: averageWeight,
      if (averageLifespan != $none) #averageLifespan: averageLifespan,
    }),
  );
  @override
  PetBreedInfo $make(CopyWithData data) => PetBreedInfo(
    id: data.get(#id, or: $value.id),
    breedName: data.get(#breedName, or: $value.breedName),
    petType: data.get(#petType, or: $value.petType),
    sizeCategory: data.get(#sizeCategory, or: $value.sizeCategory),
    temperament: data.get(#temperament, or: $value.temperament),
    averageWeight: data.get(#averageWeight, or: $value.averageWeight),
    averageLifespan: data.get(#averageLifespan, or: $value.averageLifespan),
  );

  @override
  PetBreedInfoCopyWith<$R2, PetBreedInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetBreedInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartItemPricingMapper extends ClassMapperBase<CartItemPricing> {
  CartItemPricingMapper._();

  static CartItemPricingMapper? _instance;
  static CartItemPricingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartItemPricingMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CartItemPricing';

  static String? _$basePrice(CartItemPricing v) => v.basePrice;
  static const Field<CartItemPricing, String> _f$basePrice = Field(
    'basePrice',
    _$basePrice,
    opt: true,
  );
  static int? _$quantity(CartItemPricing v) => v.quantity;
  static const Field<CartItemPricing, int> _f$quantity = Field(
    'quantity',
    _$quantity,
    opt: true,
  );
  static double? _$subtotal(CartItemPricing v) => v.subtotal;
  static const Field<CartItemPricing, double> _f$subtotal = Field(
    'subtotal',
    _$subtotal,
    opt: true,
  );
  static double? _$discount(CartItemPricing v) => v.discount;
  static const Field<CartItemPricing, double> _f$discount = Field(
    'discount',
    _$discount,
    opt: true,
  );
  static double? _$finalPrice(CartItemPricing v) => v.finalPrice;
  static const Field<CartItemPricing, double> _f$finalPrice = Field(
    'finalPrice',
    _$finalPrice,
    opt: true,
  );
  static String? _$priceUnit(CartItemPricing v) => v.priceUnit;
  static const Field<CartItemPricing, String> _f$priceUnit = Field(
    'priceUnit',
    _$priceUnit,
    opt: true,
  );
  static double? _$deliveryFee(CartItemPricing v) => v.deliveryFee;
  static const Field<CartItemPricing, double> _f$deliveryFee = Field(
    'deliveryFee',
    _$deliveryFee,
    opt: true,
  );

  @override
  final MappableFields<CartItemPricing> fields = const {
    #basePrice: _f$basePrice,
    #quantity: _f$quantity,
    #subtotal: _f$subtotal,
    #discount: _f$discount,
    #finalPrice: _f$finalPrice,
    #priceUnit: _f$priceUnit,
    #deliveryFee: _f$deliveryFee,
  };

  static CartItemPricing _instantiate(DecodingData data) {
    return CartItemPricing(
      basePrice: data.dec(_f$basePrice),
      quantity: data.dec(_f$quantity),
      subtotal: data.dec(_f$subtotal),
      discount: data.dec(_f$discount),
      finalPrice: data.dec(_f$finalPrice),
      priceUnit: data.dec(_f$priceUnit),
      deliveryFee: data.dec(_f$deliveryFee),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartItemPricing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartItemPricing>(map);
  }

  static CartItemPricing fromJson(String json) {
    return ensureInitialized().decodeJson<CartItemPricing>(json);
  }
}

mixin CartItemPricingMappable {
  String toJson() {
    return CartItemPricingMapper.ensureInitialized()
        .encodeJson<CartItemPricing>(this as CartItemPricing);
  }

  Map<String, dynamic> toMap() {
    return CartItemPricingMapper.ensureInitialized().encodeMap<CartItemPricing>(
      this as CartItemPricing,
    );
  }

  CartItemPricingCopyWith<CartItemPricing, CartItemPricing, CartItemPricing>
  get copyWith =>
      _CartItemPricingCopyWithImpl<CartItemPricing, CartItemPricing>(
        this as CartItemPricing,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartItemPricingMapper.ensureInitialized().stringifyValue(
      this as CartItemPricing,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartItemPricingMapper.ensureInitialized().equalsValue(
      this as CartItemPricing,
      other,
    );
  }

  @override
  int get hashCode {
    return CartItemPricingMapper.ensureInitialized().hashValue(
      this as CartItemPricing,
    );
  }
}

extension CartItemPricingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CartItemPricing, $Out> {
  CartItemPricingCopyWith<$R, CartItemPricing, $Out> get $asCartItemPricing =>
      $base.as((v, t, t2) => _CartItemPricingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartItemPricingCopyWith<$R, $In extends CartItemPricing, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? basePrice,
    int? quantity,
    double? subtotal,
    double? discount,
    double? finalPrice,
    String? priceUnit,
    double? deliveryFee,
  });
  CartItemPricingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CartItemPricingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartItemPricing, $Out>
    implements CartItemPricingCopyWith<$R, CartItemPricing, $Out> {
  _CartItemPricingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartItemPricing> $mapper =
      CartItemPricingMapper.ensureInitialized();
  @override
  $R call({
    Object? basePrice = $none,
    Object? quantity = $none,
    Object? subtotal = $none,
    Object? discount = $none,
    Object? finalPrice = $none,
    Object? priceUnit = $none,
    Object? deliveryFee = $none,
  }) => $apply(
    FieldCopyWithData({
      if (basePrice != $none) #basePrice: basePrice,
      if (quantity != $none) #quantity: quantity,
      if (subtotal != $none) #subtotal: subtotal,
      if (discount != $none) #discount: discount,
      if (finalPrice != $none) #finalPrice: finalPrice,
      if (priceUnit != $none) #priceUnit: priceUnit,
      if (deliveryFee != $none) #deliveryFee: deliveryFee,
    }),
  );
  @override
  CartItemPricing $make(CopyWithData data) => CartItemPricing(
    basePrice: data.get(#basePrice, or: $value.basePrice),
    quantity: data.get(#quantity, or: $value.quantity),
    subtotal: data.get(#subtotal, or: $value.subtotal),
    discount: data.get(#discount, or: $value.discount),
    finalPrice: data.get(#finalPrice, or: $value.finalPrice),
    priceUnit: data.get(#priceUnit, or: $value.priceUnit),
    deliveryFee: data.get(#deliveryFee, or: $value.deliveryFee),
  );

  @override
  CartItemPricingCopyWith<$R2, CartItemPricing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartItemPricingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartDataMapper extends ClassMapperBase<CartData> {
  CartDataMapper._();

  static CartDataMapper? _instance;
  static CartDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartDataMapper._());
      CartItemMapper.ensureInitialized();
      CartPricingMapper.ensureInitialized();
      AppliedCouponMapper.ensureInitialized();
      CartOrderSummaryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CartData';

  static String _$userId(CartData v) => v.userId;
  static const Field<CartData, String> _f$userId = Field(
    'userId',
    _$userId,
    hook: SafeStringHook(),
  );
  static List<CartItem>? _$items(CartData v) => v.items;
  static const Field<CartData, List<CartItem>> _f$items = Field(
    'items',
    _$items,
    opt: true,
  );
  static int? _$totalItems(CartData v) => v.totalItems;
  static const Field<CartData, int> _f$totalItems = Field(
    'totalItems',
    _$totalItems,
    opt: true,
  );
  static int? _$currentPage(CartData v) => v.currentPage;
  static const Field<CartData, int> _f$currentPage = Field(
    'currentPage',
    _$currentPage,
    opt: true,
  );
  static int? _$totalPages(CartData v) => v.totalPages;
  static const Field<CartData, int> _f$totalPages = Field(
    'totalPages',
    _$totalPages,
    opt: true,
  );
  static bool? _$hasNextPage(CartData v) => v.hasNextPage;
  static const Field<CartData, bool> _f$hasNextPage = Field(
    'hasNextPage',
    _$hasNextPage,
    opt: true,
  );
  static bool? _$hasPreviousPage(CartData v) => v.hasPreviousPage;
  static const Field<CartData, bool> _f$hasPreviousPage = Field(
    'hasPreviousPage',
    _$hasPreviousPage,
    opt: true,
  );
  static CartPricing? _$pricing(CartData v) => v.pricing;
  static const Field<CartData, CartPricing> _f$pricing = Field(
    'pricing',
    _$pricing,
    opt: true,
  );
  static AppliedCoupon? _$appliedCoupon(CartData v) => v.appliedCoupon;
  static const Field<CartData, AppliedCoupon> _f$appliedCoupon = Field(
    'appliedCoupon',
    _$appliedCoupon,
    opt: true,
  );
  static double? _$totalAmount(CartData v) => v.totalAmount;
  static const Field<CartData, double> _f$totalAmount = Field(
    'totalAmount',
    _$totalAmount,
    key: r'total_amount',
    opt: true,
  );
  static CartOrderSummary? _$orderSummary(CartData v) => v.orderSummary;
  static const Field<CartData, CartOrderSummary> _f$orderSummary = Field(
    'orderSummary',
    _$orderSummary,
    key: r'order_summary',
    opt: true,
  );

  @override
  final MappableFields<CartData> fields = const {
    #userId: _f$userId,
    #items: _f$items,
    #totalItems: _f$totalItems,
    #currentPage: _f$currentPage,
    #totalPages: _f$totalPages,
    #hasNextPage: _f$hasNextPage,
    #hasPreviousPage: _f$hasPreviousPage,
    #pricing: _f$pricing,
    #appliedCoupon: _f$appliedCoupon,
    #totalAmount: _f$totalAmount,
    #orderSummary: _f$orderSummary,
  };

  static CartData _instantiate(DecodingData data) {
    return CartData(
      userId: data.dec(_f$userId),
      items: data.dec(_f$items),
      totalItems: data.dec(_f$totalItems),
      currentPage: data.dec(_f$currentPage),
      totalPages: data.dec(_f$totalPages),
      hasNextPage: data.dec(_f$hasNextPage),
      hasPreviousPage: data.dec(_f$hasPreviousPage),
      pricing: data.dec(_f$pricing),
      appliedCoupon: data.dec(_f$appliedCoupon),
      totalAmount: data.dec(_f$totalAmount),
      orderSummary: data.dec(_f$orderSummary),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartData>(map);
  }

  static CartData fromJson(String json) {
    return ensureInitialized().decodeJson<CartData>(json);
  }
}

mixin CartDataMappable {
  String toJson() {
    return CartDataMapper.ensureInitialized().encodeJson<CartData>(
      this as CartData,
    );
  }

  Map<String, dynamic> toMap() {
    return CartDataMapper.ensureInitialized().encodeMap<CartData>(
      this as CartData,
    );
  }

  CartDataCopyWith<CartData, CartData, CartData> get copyWith =>
      _CartDataCopyWithImpl<CartData, CartData>(
        this as CartData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartDataMapper.ensureInitialized().stringifyValue(this as CartData);
  }

  @override
  bool operator ==(Object other) {
    return CartDataMapper.ensureInitialized().equalsValue(
      this as CartData,
      other,
    );
  }

  @override
  int get hashCode {
    return CartDataMapper.ensureInitialized().hashValue(this as CartData);
  }
}

extension CartDataValueCopy<$R, $Out> on ObjectCopyWith<$R, CartData, $Out> {
  CartDataCopyWith<$R, CartData, $Out> get $asCartData =>
      $base.as((v, t, t2) => _CartDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartDataCopyWith<$R, $In extends CartData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CartItem, CartItemCopyWith<$R, CartItem, CartItem>>?
  get items;
  CartPricingCopyWith<$R, CartPricing, CartPricing>? get pricing;
  AppliedCouponCopyWith<$R, AppliedCoupon, AppliedCoupon>? get appliedCoupon;
  CartOrderSummaryCopyWith<$R, CartOrderSummary, CartOrderSummary>?
  get orderSummary;
  $R call({
    String? userId,
    List<CartItem>? items,
    int? totalItems,
    int? currentPage,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPreviousPage,
    CartPricing? pricing,
    AppliedCoupon? appliedCoupon,
    double? totalAmount,
    CartOrderSummary? orderSummary,
  });
  CartDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartData, $Out>
    implements CartDataCopyWith<$R, CartData, $Out> {
  _CartDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartData> $mapper =
      CartDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CartItem, CartItemCopyWith<$R, CartItem, CartItem>>?
  get items => $value.items != null
      ? ListCopyWith(
          $value.items!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(items: v),
        )
      : null;
  @override
  CartPricingCopyWith<$R, CartPricing, CartPricing>? get pricing =>
      $value.pricing?.copyWith.$chain((v) => call(pricing: v));
  @override
  AppliedCouponCopyWith<$R, AppliedCoupon, AppliedCoupon>? get appliedCoupon =>
      $value.appliedCoupon?.copyWith.$chain((v) => call(appliedCoupon: v));
  @override
  CartOrderSummaryCopyWith<$R, CartOrderSummary, CartOrderSummary>?
  get orderSummary =>
      $value.orderSummary?.copyWith.$chain((v) => call(orderSummary: v));
  @override
  $R call({
    String? userId,
    Object? items = $none,
    Object? totalItems = $none,
    Object? currentPage = $none,
    Object? totalPages = $none,
    Object? hasNextPage = $none,
    Object? hasPreviousPage = $none,
    Object? pricing = $none,
    Object? appliedCoupon = $none,
    Object? totalAmount = $none,
    Object? orderSummary = $none,
  }) => $apply(
    FieldCopyWithData({
      if (userId != null) #userId: userId,
      if (items != $none) #items: items,
      if (totalItems != $none) #totalItems: totalItems,
      if (currentPage != $none) #currentPage: currentPage,
      if (totalPages != $none) #totalPages: totalPages,
      if (hasNextPage != $none) #hasNextPage: hasNextPage,
      if (hasPreviousPage != $none) #hasPreviousPage: hasPreviousPage,
      if (pricing != $none) #pricing: pricing,
      if (appliedCoupon != $none) #appliedCoupon: appliedCoupon,
      if (totalAmount != $none) #totalAmount: totalAmount,
      if (orderSummary != $none) #orderSummary: orderSummary,
    }),
  );
  @override
  CartData $make(CopyWithData data) => CartData(
    userId: data.get(#userId, or: $value.userId),
    items: data.get(#items, or: $value.items),
    totalItems: data.get(#totalItems, or: $value.totalItems),
    currentPage: data.get(#currentPage, or: $value.currentPage),
    totalPages: data.get(#totalPages, or: $value.totalPages),
    hasNextPage: data.get(#hasNextPage, or: $value.hasNextPage),
    hasPreviousPage: data.get(#hasPreviousPage, or: $value.hasPreviousPage),
    pricing: data.get(#pricing, or: $value.pricing),
    appliedCoupon: data.get(#appliedCoupon, or: $value.appliedCoupon),
    totalAmount: data.get(#totalAmount, or: $value.totalAmount),
    orderSummary: data.get(#orderSummary, or: $value.orderSummary),
  );

  @override
  CartDataCopyWith<$R2, CartData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartPricingMapper extends ClassMapperBase<CartPricing> {
  CartPricingMapper._();

  static CartPricingMapper? _instance;
  static CartPricingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartPricingMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CartPricing';

  static double? _$subtotal(CartPricing v) => v.subtotal;
  static const Field<CartPricing, double> _f$subtotal = Field(
    'subtotal',
    _$subtotal,
    opt: true,
  );
  static double? _$totalDiscount(CartPricing v) => v.totalDiscount;
  static const Field<CartPricing, double> _f$totalDiscount = Field(
    'totalDiscount',
    _$totalDiscount,
    opt: true,
  );
  static double? _$finalTotal(CartPricing v) => v.finalTotal;
  static const Field<CartPricing, double> _f$finalTotal = Field(
    'finalTotal',
    _$finalTotal,
    opt: true,
  );
  static bool? _$hasCouponApplied(CartPricing v) => v.hasCouponApplied;
  static const Field<CartPricing, bool> _f$hasCouponApplied = Field(
    'hasCouponApplied',
    _$hasCouponApplied,
    opt: true,
  );

  @override
  final MappableFields<CartPricing> fields = const {
    #subtotal: _f$subtotal,
    #totalDiscount: _f$totalDiscount,
    #finalTotal: _f$finalTotal,
    #hasCouponApplied: _f$hasCouponApplied,
  };

  static CartPricing _instantiate(DecodingData data) {
    return CartPricing(
      subtotal: data.dec(_f$subtotal),
      totalDiscount: data.dec(_f$totalDiscount),
      finalTotal: data.dec(_f$finalTotal),
      hasCouponApplied: data.dec(_f$hasCouponApplied),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartPricing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartPricing>(map);
  }

  static CartPricing fromJson(String json) {
    return ensureInitialized().decodeJson<CartPricing>(json);
  }
}

mixin CartPricingMappable {
  String toJson() {
    return CartPricingMapper.ensureInitialized().encodeJson<CartPricing>(
      this as CartPricing,
    );
  }

  Map<String, dynamic> toMap() {
    return CartPricingMapper.ensureInitialized().encodeMap<CartPricing>(
      this as CartPricing,
    );
  }

  CartPricingCopyWith<CartPricing, CartPricing, CartPricing> get copyWith =>
      _CartPricingCopyWithImpl<CartPricing, CartPricing>(
        this as CartPricing,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartPricingMapper.ensureInitialized().stringifyValue(
      this as CartPricing,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartPricingMapper.ensureInitialized().equalsValue(
      this as CartPricing,
      other,
    );
  }

  @override
  int get hashCode {
    return CartPricingMapper.ensureInitialized().hashValue(this as CartPricing);
  }
}

extension CartPricingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CartPricing, $Out> {
  CartPricingCopyWith<$R, CartPricing, $Out> get $asCartPricing =>
      $base.as((v, t, t2) => _CartPricingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartPricingCopyWith<$R, $In extends CartPricing, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    double? subtotal,
    double? totalDiscount,
    double? finalTotal,
    bool? hasCouponApplied,
  });
  CartPricingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartPricingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartPricing, $Out>
    implements CartPricingCopyWith<$R, CartPricing, $Out> {
  _CartPricingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartPricing> $mapper =
      CartPricingMapper.ensureInitialized();
  @override
  $R call({
    Object? subtotal = $none,
    Object? totalDiscount = $none,
    Object? finalTotal = $none,
    Object? hasCouponApplied = $none,
  }) => $apply(
    FieldCopyWithData({
      if (subtotal != $none) #subtotal: subtotal,
      if (totalDiscount != $none) #totalDiscount: totalDiscount,
      if (finalTotal != $none) #finalTotal: finalTotal,
      if (hasCouponApplied != $none) #hasCouponApplied: hasCouponApplied,
    }),
  );
  @override
  CartPricing $make(CopyWithData data) => CartPricing(
    subtotal: data.get(#subtotal, or: $value.subtotal),
    totalDiscount: data.get(#totalDiscount, or: $value.totalDiscount),
    finalTotal: data.get(#finalTotal, or: $value.finalTotal),
    hasCouponApplied: data.get(#hasCouponApplied, or: $value.hasCouponApplied),
  );

  @override
  CartPricingCopyWith<$R2, CartPricing, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartPricingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppliedCouponMapper extends ClassMapperBase<AppliedCoupon> {
  AppliedCouponMapper._();

  static AppliedCouponMapper? _instance;
  static AppliedCouponMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppliedCouponMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppliedCoupon';

  static String? _$couponCode(AppliedCoupon v) => v.couponCode;
  static const Field<AppliedCoupon, String> _f$couponCode = Field(
    'couponCode',
    _$couponCode,
    opt: true,
  );
  static DateTime? _$appliedAt(AppliedCoupon v) => v.appliedAt;
  static const Field<AppliedCoupon, DateTime> _f$appliedAt = Field(
    'appliedAt',
    _$appliedAt,
    opt: true,
  );
  static String? _$discountType(AppliedCoupon v) => v.discountType;
  static const Field<AppliedCoupon, String> _f$discountType = Field(
    'discountType',
    _$discountType,
    opt: true,
  );
  static String? _$discountValue(AppliedCoupon v) => v.discountValue;
  static const Field<AppliedCoupon, String> _f$discountValue = Field(
    'discountValue',
    _$discountValue,
    opt: true,
  );
  static double? _$minimumOrderAmount(AppliedCoupon v) => v.minimumOrderAmount;
  static const Field<AppliedCoupon, double> _f$minimumOrderAmount = Field(
    'minimumOrderAmount',
    _$minimumOrderAmount,
    opt: true,
  );
  static double? _$maximumDiscountAmount(AppliedCoupon v) =>
      v.maximumDiscountAmount;
  static const Field<AppliedCoupon, double> _f$maximumDiscountAmount = Field(
    'maximumDiscountAmount',
    _$maximumDiscountAmount,
    opt: true,
  );
  static DateTime? _$validFrom(AppliedCoupon v) => v.validFrom;
  static const Field<AppliedCoupon, DateTime> _f$validFrom = Field(
    'validFrom',
    _$validFrom,
    opt: true,
  );
  static DateTime? _$validTo(AppliedCoupon v) => v.validTo;
  static const Field<AppliedCoupon, DateTime> _f$validTo = Field(
    'validTo',
    _$validTo,
    opt: true,
  );
  static String? _$status(AppliedCoupon v) => v.status;
  static const Field<AppliedCoupon, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static double? _$totalDiscountApplied(AppliedCoupon v) =>
      v.totalDiscountApplied;
  static const Field<AppliedCoupon, double> _f$totalDiscountApplied = Field(
    'totalDiscountApplied',
    _$totalDiscountApplied,
    opt: true,
  );

  @override
  final MappableFields<AppliedCoupon> fields = const {
    #couponCode: _f$couponCode,
    #appliedAt: _f$appliedAt,
    #discountType: _f$discountType,
    #discountValue: _f$discountValue,
    #minimumOrderAmount: _f$minimumOrderAmount,
    #maximumDiscountAmount: _f$maximumDiscountAmount,
    #validFrom: _f$validFrom,
    #validTo: _f$validTo,
    #status: _f$status,
    #totalDiscountApplied: _f$totalDiscountApplied,
  };

  static AppliedCoupon _instantiate(DecodingData data) {
    return AppliedCoupon(
      couponCode: data.dec(_f$couponCode),
      appliedAt: data.dec(_f$appliedAt),
      discountType: data.dec(_f$discountType),
      discountValue: data.dec(_f$discountValue),
      minimumOrderAmount: data.dec(_f$minimumOrderAmount),
      maximumDiscountAmount: data.dec(_f$maximumDiscountAmount),
      validFrom: data.dec(_f$validFrom),
      validTo: data.dec(_f$validTo),
      status: data.dec(_f$status),
      totalDiscountApplied: data.dec(_f$totalDiscountApplied),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppliedCoupon fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppliedCoupon>(map);
  }

  static AppliedCoupon fromJson(String json) {
    return ensureInitialized().decodeJson<AppliedCoupon>(json);
  }
}

mixin AppliedCouponMappable {
  String toJson() {
    return AppliedCouponMapper.ensureInitialized().encodeJson<AppliedCoupon>(
      this as AppliedCoupon,
    );
  }

  Map<String, dynamic> toMap() {
    return AppliedCouponMapper.ensureInitialized().encodeMap<AppliedCoupon>(
      this as AppliedCoupon,
    );
  }

  AppliedCouponCopyWith<AppliedCoupon, AppliedCoupon, AppliedCoupon>
  get copyWith => _AppliedCouponCopyWithImpl<AppliedCoupon, AppliedCoupon>(
    this as AppliedCoupon,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AppliedCouponMapper.ensureInitialized().stringifyValue(
      this as AppliedCoupon,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppliedCouponMapper.ensureInitialized().equalsValue(
      this as AppliedCoupon,
      other,
    );
  }

  @override
  int get hashCode {
    return AppliedCouponMapper.ensureInitialized().hashValue(
      this as AppliedCoupon,
    );
  }
}

extension AppliedCouponValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppliedCoupon, $Out> {
  AppliedCouponCopyWith<$R, AppliedCoupon, $Out> get $asAppliedCoupon =>
      $base.as((v, t, t2) => _AppliedCouponCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppliedCouponCopyWith<$R, $In extends AppliedCoupon, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? couponCode,
    DateTime? appliedAt,
    String? discountType,
    String? discountValue,
    double? minimumOrderAmount,
    double? maximumDiscountAmount,
    DateTime? validFrom,
    DateTime? validTo,
    String? status,
    double? totalDiscountApplied,
  });
  AppliedCouponCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppliedCouponCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppliedCoupon, $Out>
    implements AppliedCouponCopyWith<$R, AppliedCoupon, $Out> {
  _AppliedCouponCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppliedCoupon> $mapper =
      AppliedCouponMapper.ensureInitialized();
  @override
  $R call({
    Object? couponCode = $none,
    Object? appliedAt = $none,
    Object? discountType = $none,
    Object? discountValue = $none,
    Object? minimumOrderAmount = $none,
    Object? maximumDiscountAmount = $none,
    Object? validFrom = $none,
    Object? validTo = $none,
    Object? status = $none,
    Object? totalDiscountApplied = $none,
  }) => $apply(
    FieldCopyWithData({
      if (couponCode != $none) #couponCode: couponCode,
      if (appliedAt != $none) #appliedAt: appliedAt,
      if (discountType != $none) #discountType: discountType,
      if (discountValue != $none) #discountValue: discountValue,
      if (minimumOrderAmount != $none) #minimumOrderAmount: minimumOrderAmount,
      if (maximumDiscountAmount != $none)
        #maximumDiscountAmount: maximumDiscountAmount,
      if (validFrom != $none) #validFrom: validFrom,
      if (validTo != $none) #validTo: validTo,
      if (status != $none) #status: status,
      if (totalDiscountApplied != $none)
        #totalDiscountApplied: totalDiscountApplied,
    }),
  );
  @override
  AppliedCoupon $make(CopyWithData data) => AppliedCoupon(
    couponCode: data.get(#couponCode, or: $value.couponCode),
    appliedAt: data.get(#appliedAt, or: $value.appliedAt),
    discountType: data.get(#discountType, or: $value.discountType),
    discountValue: data.get(#discountValue, or: $value.discountValue),
    minimumOrderAmount: data.get(
      #minimumOrderAmount,
      or: $value.minimumOrderAmount,
    ),
    maximumDiscountAmount: data.get(
      #maximumDiscountAmount,
      or: $value.maximumDiscountAmount,
    ),
    validFrom: data.get(#validFrom, or: $value.validFrom),
    validTo: data.get(#validTo, or: $value.validTo),
    status: data.get(#status, or: $value.status),
    totalDiscountApplied: data.get(
      #totalDiscountApplied,
      or: $value.totalDiscountApplied,
    ),
  );

  @override
  AppliedCouponCopyWith<$R2, AppliedCoupon, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppliedCouponCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartOrderSummaryMapper extends ClassMapperBase<CartOrderSummary> {
  CartOrderSummaryMapper._();

  static CartOrderSummaryMapper? _instance;
  static CartOrderSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartOrderSummaryMapper._());
      CartOrderItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CartOrderSummary';

  static List<CartOrderItem>? _$items(CartOrderSummary v) => v.items;
  static const Field<CartOrderSummary, List<CartOrderItem>> _f$items = Field(
    'items',
    _$items,
    opt: true,
  );
  static double? _$subTotal(CartOrderSummary v) => v.subTotal;
  static const Field<CartOrderSummary, double> _f$subTotal = Field(
    'subTotal',
    _$subTotal,
    key: r'sub_total',
    opt: true,
  );
  static double? _$deliveryFee(CartOrderSummary v) => v.deliveryFee;
  static const Field<CartOrderSummary, double> _f$deliveryFee = Field(
    'deliveryFee',
    _$deliveryFee,
    key: r'delivery_fee',
    opt: true,
  );
  static double? _$tax(CartOrderSummary v) => v.tax;
  static const Field<CartOrderSummary, double> _f$tax = Field(
    'tax',
    _$tax,
    opt: true,
  );
  static double? _$discount(CartOrderSummary v) => v.discount;
  static const Field<CartOrderSummary, double> _f$discount = Field(
    'discount',
    _$discount,
    opt: true,
  );
  static List<dynamic>? _$addOns(CartOrderSummary v) => v.addOns;
  static const Field<CartOrderSummary, List<dynamic>> _f$addOns = Field(
    'addOns',
    _$addOns,
    key: r'add_ons',
    opt: true,
  );
  static double? _$total(CartOrderSummary v) => v.total;
  static const Field<CartOrderSummary, double> _f$total = Field(
    'total',
    _$total,
    opt: true,
  );

  @override
  final MappableFields<CartOrderSummary> fields = const {
    #items: _f$items,
    #subTotal: _f$subTotal,
    #deliveryFee: _f$deliveryFee,
    #tax: _f$tax,
    #discount: _f$discount,
    #addOns: _f$addOns,
    #total: _f$total,
  };

  static CartOrderSummary _instantiate(DecodingData data) {
    return CartOrderSummary(
      items: data.dec(_f$items),
      subTotal: data.dec(_f$subTotal),
      deliveryFee: data.dec(_f$deliveryFee),
      tax: data.dec(_f$tax),
      discount: data.dec(_f$discount),
      addOns: data.dec(_f$addOns),
      total: data.dec(_f$total),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartOrderSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartOrderSummary>(map);
  }

  static CartOrderSummary fromJson(String json) {
    return ensureInitialized().decodeJson<CartOrderSummary>(json);
  }
}

mixin CartOrderSummaryMappable {
  String toJson() {
    return CartOrderSummaryMapper.ensureInitialized()
        .encodeJson<CartOrderSummary>(this as CartOrderSummary);
  }

  Map<String, dynamic> toMap() {
    return CartOrderSummaryMapper.ensureInitialized()
        .encodeMap<CartOrderSummary>(this as CartOrderSummary);
  }

  CartOrderSummaryCopyWith<CartOrderSummary, CartOrderSummary, CartOrderSummary>
  get copyWith =>
      _CartOrderSummaryCopyWithImpl<CartOrderSummary, CartOrderSummary>(
        this as CartOrderSummary,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartOrderSummaryMapper.ensureInitialized().stringifyValue(
      this as CartOrderSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartOrderSummaryMapper.ensureInitialized().equalsValue(
      this as CartOrderSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return CartOrderSummaryMapper.ensureInitialized().hashValue(
      this as CartOrderSummary,
    );
  }
}

extension CartOrderSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CartOrderSummary, $Out> {
  CartOrderSummaryCopyWith<$R, CartOrderSummary, $Out>
  get $asCartOrderSummary =>
      $base.as((v, t, t2) => _CartOrderSummaryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartOrderSummaryCopyWith<$R, $In extends CartOrderSummary, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    CartOrderItem,
    CartOrderItemCopyWith<$R, CartOrderItem, CartOrderItem>
  >?
  get items;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get addOns;
  $R call({
    List<CartOrderItem>? items,
    double? subTotal,
    double? deliveryFee,
    double? tax,
    double? discount,
    List<dynamic>? addOns,
    double? total,
  });
  CartOrderSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CartOrderSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartOrderSummary, $Out>
    implements CartOrderSummaryCopyWith<$R, CartOrderSummary, $Out> {
  _CartOrderSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartOrderSummary> $mapper =
      CartOrderSummaryMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    CartOrderItem,
    CartOrderItemCopyWith<$R, CartOrderItem, CartOrderItem>
  >?
  get items => $value.items != null
      ? ListCopyWith(
          $value.items!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(items: v),
        )
      : null;
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get addOns => $value.addOns != null
      ? ListCopyWith(
          $value.addOns!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(addOns: v),
        )
      : null;
  @override
  $R call({
    Object? items = $none,
    Object? subTotal = $none,
    Object? deliveryFee = $none,
    Object? tax = $none,
    Object? discount = $none,
    Object? addOns = $none,
    Object? total = $none,
  }) => $apply(
    FieldCopyWithData({
      if (items != $none) #items: items,
      if (subTotal != $none) #subTotal: subTotal,
      if (deliveryFee != $none) #deliveryFee: deliveryFee,
      if (tax != $none) #tax: tax,
      if (discount != $none) #discount: discount,
      if (addOns != $none) #addOns: addOns,
      if (total != $none) #total: total,
    }),
  );
  @override
  CartOrderSummary $make(CopyWithData data) => CartOrderSummary(
    items: data.get(#items, or: $value.items),
    subTotal: data.get(#subTotal, or: $value.subTotal),
    deliveryFee: data.get(#deliveryFee, or: $value.deliveryFee),
    tax: data.get(#tax, or: $value.tax),
    discount: data.get(#discount, or: $value.discount),
    addOns: data.get(#addOns, or: $value.addOns),
    total: data.get(#total, or: $value.total),
  );

  @override
  CartOrderSummaryCopyWith<$R2, CartOrderSummary, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartOrderSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartOrderItemMapper extends ClassMapperBase<CartOrderItem> {
  CartOrderItemMapper._();

  static CartOrderItemMapper? _instance;
  static CartOrderItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartOrderItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CartOrderItem';

  static String? _$title(CartOrderItem v) => v.title;
  static const Field<CartOrderItem, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static double? _$price(CartOrderItem v) => v.price;
  static const Field<CartOrderItem, double> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static String? _$priceUnit(CartOrderItem v) => v.priceUnit;
  static const Field<CartOrderItem, String> _f$priceUnit = Field(
    'priceUnit',
    _$priceUnit,
    opt: true,
  );
  static double? _$deliveryFee(CartOrderItem v) => v.deliveryFee;
  static const Field<CartOrderItem, double> _f$deliveryFee = Field(
    'deliveryFee',
    _$deliveryFee,
    key: r'delivery_fee',
    opt: true,
  );

  @override
  final MappableFields<CartOrderItem> fields = const {
    #title: _f$title,
    #price: _f$price,
    #priceUnit: _f$priceUnit,
    #deliveryFee: _f$deliveryFee,
  };

  static CartOrderItem _instantiate(DecodingData data) {
    return CartOrderItem(
      title: data.dec(_f$title),
      price: data.dec(_f$price),
      priceUnit: data.dec(_f$priceUnit),
      deliveryFee: data.dec(_f$deliveryFee),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartOrderItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartOrderItem>(map);
  }

  static CartOrderItem fromJson(String json) {
    return ensureInitialized().decodeJson<CartOrderItem>(json);
  }
}

mixin CartOrderItemMappable {
  String toJson() {
    return CartOrderItemMapper.ensureInitialized().encodeJson<CartOrderItem>(
      this as CartOrderItem,
    );
  }

  Map<String, dynamic> toMap() {
    return CartOrderItemMapper.ensureInitialized().encodeMap<CartOrderItem>(
      this as CartOrderItem,
    );
  }

  CartOrderItemCopyWith<CartOrderItem, CartOrderItem, CartOrderItem>
  get copyWith => _CartOrderItemCopyWithImpl<CartOrderItem, CartOrderItem>(
    this as CartOrderItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CartOrderItemMapper.ensureInitialized().stringifyValue(
      this as CartOrderItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return CartOrderItemMapper.ensureInitialized().equalsValue(
      this as CartOrderItem,
      other,
    );
  }

  @override
  int get hashCode {
    return CartOrderItemMapper.ensureInitialized().hashValue(
      this as CartOrderItem,
    );
  }
}

extension CartOrderItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CartOrderItem, $Out> {
  CartOrderItemCopyWith<$R, CartOrderItem, $Out> get $asCartOrderItem =>
      $base.as((v, t, t2) => _CartOrderItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartOrderItemCopyWith<$R, $In extends CartOrderItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    double? price,
    String? priceUnit,
    double? deliveryFee,
  });
  CartOrderItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartOrderItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartOrderItem, $Out>
    implements CartOrderItemCopyWith<$R, CartOrderItem, $Out> {
  _CartOrderItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartOrderItem> $mapper =
      CartOrderItemMapper.ensureInitialized();
  @override
  $R call({
    Object? title = $none,
    Object? price = $none,
    Object? priceUnit = $none,
    Object? deliveryFee = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != $none) #title: title,
      if (price != $none) #price: price,
      if (priceUnit != $none) #priceUnit: priceUnit,
      if (deliveryFee != $none) #deliveryFee: deliveryFee,
    }),
  );
  @override
  CartOrderItem $make(CopyWithData data) => CartOrderItem(
    title: data.get(#title, or: $value.title),
    price: data.get(#price, or: $value.price),
    priceUnit: data.get(#priceUnit, or: $value.priceUnit),
    deliveryFee: data.get(#deliveryFee, or: $value.deliveryFee),
  );

  @override
  CartOrderItemCopyWith<$R2, CartOrderItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartOrderItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

