import 'package:flutter/material.dart';

/// Singleton service to control global loader visibility.
/// Use LoaderService.instance.show() and LoaderService.instance.hide() anywhere.
class LoaderService extends ChangeNotifier {
  static final LoaderService _instance = LoaderService._internal();
  factory LoaderService() => _instance;
  LoaderService._internal();

  static LoaderService get instance => _instance;

  bool _isLoading = false;
  Widget? _customLoader;

  bool get isLoading => _isLoading;
  Widget? get customLoader => _customLoader;

  /// Show loader. Optionally provide a custom loader widget.
  void show({Widget? loader}) {
    _isLoading = true;
    _customLoader = loader;
    notifyListeners();
  }

  /// Hide loader.
  void hide() {
    _isLoading = false;
    _customLoader = null;
    notifyListeners();
  }
}
