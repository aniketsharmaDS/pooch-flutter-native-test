import 'package:dio/dio.dart';
import 'package:poochcare/core/services/localization_service.dart';

class LocalizationInterceptor extends Interceptor {
  LocalizationInterceptor({required LocalizationService localizationService})
    : _localizationService = localizationService;

  final LocalizationService _localizationService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentLang = await _localizationService.getCurrentLanguage();

    /// QUERY PARAM
    options.queryParameters = {...options.queryParameters, 'lang': currentLang};

    /// STANDARD HEADER
    options.headers['Accept-Language'] = currentLang;

    handler.next(options);
  }
}
