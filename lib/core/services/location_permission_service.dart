import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/find_pooches_dialog.dart';

class LocationPermissionService {
  LocationPermissionService(this._storage);

  final SecureStorageService _storage;

  /// Main flow
  Future<bool> requestLocationPermissionFlow(BuildContext context) async {
    if (!context.mounted) return false;

    // 1. Check OS permission
    final status = await Permission.location.status;

    if (!context.mounted) return false;

    // 2. If already granted in OS
    if (status.isGranted) {
      await _storage.writeBool(
        SecureStorageKeys.locationPermissionGranted,
        true,
      );
      return true;
    }

    // 3. Always show custom dialog first
    final userChoice = await FindPoochesDialog.show(context);

    if (!context.mounted) return false;

    // 4. User denied in custom dialog
    if (userChoice != true) {
      await _storage.writeBool(
        SecureStorageKeys.locationPermissionGranted,
        false,
      );
      return false;
    }

    // 5. Request OS permission
    final result = await Permission.location.request();

    if (result.isGranted) {
      await _storage.writeBool(
        SecureStorageKeys.locationPermissionGranted,
        true,
      );
      return true;
    }

    await _storage.writeBool(
      SecureStorageKeys.locationPermissionGranted,
      false,
    );

    // 6. Permanently denied → open settings
    if (result.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }
}
