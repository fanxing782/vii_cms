import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path/path.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  final CancelToken _cancelToken = CancelToken();
  late Dio _dio;
  ApiClient._internal();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    BaseOptions options = BaseOptions(
      baseUrl: 'https://www.zhihu.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json;Charset=UTF-8',
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // options.headers['Authorization'] = 'Bearer your_token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // ...
          }
          return handler.next(e);
        },
      ),
    );

    // Only debug
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        error: true,
      ),
    );

    _isInitialized = true;
  }

  void cancelRequests() {
    _cancelToken.cancel('[api_client] Request cancelled');
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'No internet connection',
      );
    }

    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'No internet connection',
      );
    }

    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'No internet connection',
      );
    }

    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'No internet connection',
      );
    }

    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: _cancelToken,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // File upload
  Future<Response> uploadFile(
    String path, {
    required File file,
    String? fileName,
    Map<String, dynamic>? formData,
    Options? options,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'No internet connection',
      );
    }

    String name = fileName ?? basename(file.path);
    FormData data = FormData.fromMap({
      ...?formData,
      'file': await MultipartFile.fromFile(file.path, filename: name),
    });

    try {
      return await _dio.post(
        path,
        data: data,
        options: options ?? Options(contentType: 'multipart/form-data'),
        cancelToken: _cancelToken,
        onSendProgress: (int sent, int total) {
          print(
            '[api_client] Upload progress: ${(sent / total * 100).toStringAsFixed(0)}%',
          );
        },
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // Multip files upload
  Future<Response> uploadMultipleFiles(
    String path, {
    required List<File> files,
    Map<String, dynamic>? formData,
    Options? options,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'No internet connection',
      );
    }

    FormData data = FormData.fromMap({...?formData});

    for (var file in files) {
      data.files.add(
        MapEntry(
          'files',
          await MultipartFile.fromFile(
            file.path,
            filename: basename(file.path),
          ),
        ),
      );
    }

    try {
      return await _dio.post(
        path,
        data: data,
        options: options ?? Options(contentType: 'multipart/form-data'),
        cancelToken: _cancelToken,
        onSendProgress: (int sent, int total) {
          print(
            '[api_client] Upload progress: ${(sent / total * 100).toStringAsFixed(0)}%',
          );
        },
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  // Handle dio error
  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw 'Connection timeout';
      case DioExceptionType.sendTimeout:
        throw 'Send timeout';
      case DioExceptionType.receiveTimeout:
        throw 'Receive timeout';
      case DioExceptionType.badCertificate:
        throw 'Bad certificate';
      case DioExceptionType.badResponse:
        _handleResponseError(e.response!);
        break;
      case DioExceptionType.cancel:
        throw 'Request cancelled';
      case DioExceptionType.connectionError:
        throw 'Connection error';
      case DioExceptionType.unknown:
        throw 'Unknown error: ${e.message}';
    }
  }

  // Handle http status code error
  void _handleResponseError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw 'Bad request';
      case 401:
        throw 'Unauthorized';
      case 403:
        throw 'Forbidden';
      case 404:
        throw 'Not found';
      case 500:
        throw 'Internal server error';
      case 502:
        throw 'Bad gateway';
      default:
        throw 'HTTP error: ${response.statusCode}';
    }
  }
}
