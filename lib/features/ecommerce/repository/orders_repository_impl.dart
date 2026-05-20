import 'dart:io';

import 'package:poochcare/core/services/image_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/features/ecommerce/data/api/orders_api_service.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/order_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_details_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_preview_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/orders_reponse_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/paginated_orders.dart';
import 'package:poochcare/features/ecommerce/domain/repository/orders_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/reason_for_cancellation_section.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrdersApiService _api;
  final ImageUploadService _imageUploadService;
  final AuthStoreBloc _authStore;

  const OrderRepositoryImpl(
    this._api,
    this._imageUploadService,
    this._authStore,
  );

  @override
  Future<OrderPreviewModel> previewOrder({required String productId}) {
    return _api.previewOrder(productId: productId);
  }

  @override
  Future<PaginatedOrders> getOrders({required int page, String? status}) async {
    final OrderResponseModel response = await _api.getOrders(
      page: page,
      status: status,
    );

    /// 🔥 Flatten + map
    final List<OrderItemModel> items = OrderMapper.toUiList(response.orders);

    return PaginatedOrders(
      orders: items,
      total: response.total,
      page: response.page,
      pages: response.pages,
    );
  }

  @override
  Future<OrderDetailModel> getOrderById(String orderId, String itemId) {
    return _api.getOrderById(orderId, itemId);
  }

  @override
  Future<void> submitNeedHelp({
    required String issue,
    String? orderId,
    String? itemId,
  }) {
    return _api.submitNeedHelp(issue: issue, orderId: orderId, itemId: itemId);
  }

  @override
  Future<(List<CancellationReasonOption>, String)> getCancellationReasons() {
    return _api.getCancellationReasons();
  }

  /// 🔥 MAIN CANCEL FLOW
  @override
  Future<void> cancelOrder({
    required String orderId,
    required String itemId,
    required String reason,
    List<File> images = const [],
  }) async {
    final uploadedUrls = await _uploadImages(images);

    return _api.cancelOrder(
      orderId: orderId,
      itemId: itemId,
      reason: reason,
      images: uploadedUrls,
    );
  }

  /// 🔥 REUSABLE MULTI-UPLOAD (CLEAN)
  Future<List<String>> _uploadImages(List<File> images) async {
    final userId = _authStore.state.user?.id;

    if (userId == null || userId.trim().isEmpty) {
      throw ArgumentError('Cannot upload images: missing userId');
    }
    if (images.isEmpty) return [];

    final futures = images.map((file) async {
      if (!await file.exists()) {
        throw ArgumentError('Image file does not exist: ${file.path}');
      }

      final originalFileName = file.path.split(Platform.pathSeparator).last;

      final mimeType = ImageUploadService.inferImageMimeTypeFromFileName(
        originalFileName,
      );

      final fileName = ImageUploadService.sanitizeUploadFileName(
        originalFileName: originalFileName,
        mimeType: mimeType,
      );

      final bytes = await file.readAsBytes();

      /// 🔥 CLEAN S3 PATH (LIKE USER PROFILE)
      final basePath = S3UploadPathBuilder.build(
        entityType: UploadEntityType.orders,
        userId: userId, // ⚠️ replace with actual userId
        purpose: UploadPurpose.cancellation,
      );

      return _imageUploadService.uploadSingleAndGetFullUrl(
        file: UploadUrlFileSpec(path: basePath, name: fileName, type: mimeType),
        fileBytes: bytes,
      );
    });

    return Future.wait(futures); // ⚡ parallel upload
  }
}
