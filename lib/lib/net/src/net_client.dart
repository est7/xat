import 'package:flutter/foundation.dart';
import '../flutter_net.dart';
import 'network_connectivity.dart';
import 'typedefs.dart';

/// Handy method to make http GET request, which is a alias of  [dio.fetch(RequestOptions)].
/// decodeType 为空返回原始数据
/// 前者T是接口返回的数据需要序列化的类型，后者是开发关注的类型。比如接口返回一个用户列表，前面泛型就是User类型，后面是List<User>。
/// 又或者接口返回的数据包了几层，我们只需要最里面的数据格式，那么前面就是需要序列化的整个数据类型
Future<Result<K>> get<T extends BaseNetModel, K>(
  String path, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onReceiveProgress,
  NetDecoder? httpDecode,
  NetConverter<K>? converter,
  T? decodeType,
}) async {
  assert(!(httpDecode != null && converter != null),
      'httpDecode和converter不能同时赋值，请删除一个');
  return await _execute(
    path,
    'GET',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onReceiveProgress: onReceiveProgress,
    httpDecode: httpDecode,
    converter: converter,
    decodeType: decodeType,
  );
}

/// Handy method to make http POST request, which is a alias of  [dio.fetch(RequestOptions)].
/// decodeType 为空返回原始数据
Future<Result<K>> post<T extends BaseNetModel, K>(
  String path, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
  NetDecoder? httpDecode,
  NetConverter<K>? converter,
  T? decodeType,
}) async {
  assert(!(httpDecode != null && converter != null),
      'httpDecode和converter不能同时赋值，请删除一个');
  return await _execute(
    path,
    'POST',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
    httpDecode: httpDecode,
    converter: converter,
    decodeType: decodeType,
  );
}

/// Handy method to make http PUT request, which is a alias of  [dio.fetch(RequestOptions)].
/// decodeType 为空返回原始数据
Future<Result<K>> put<T extends BaseNetModel, K>(
  String path, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
  NetDecoder? httpDecode,
  NetConverter<K>? converter,
  T? decodeType,
}) async {
  assert(!(httpDecode != null && converter != null),
      'httpDecode和converter不能同时赋值，请删除一个');
  return await _execute(
    path,
    'PUT',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
    httpDecode: httpDecode,
    converter: converter,
    decodeType: decodeType,
  );
}

/// Handy method to make http HEAD request, which is a alias of [dio.fetch(RequestOptions)].
/// decodeType 为空返回原始数据
Future<Result<K>> head<T extends BaseNetModel, K>(
  String path, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  NetDecoder? httpDecode,
  NetConverter<K>? converter,
  T? decodeType,
}) async {
  assert(!(httpDecode != null && converter != null),
      'httpDecode和converter不能同时赋值，请删除一个');
  return await _execute(
    path,
    'HEAD',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    httpDecode: httpDecode,
    converter: converter,
    decodeType: decodeType,
  );
}

/// Handy method to make http DELETE request, which is a alias of  [dio.fetch(RequestOptions)].
/// decodeType 为空返回原始数据
Future<Result<K>> delete<T extends BaseNetModel, K>(
  String path, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  NetDecoder? httpDecode,
  NetConverter<K>? converter,
  T? decodeType,
}) async {
  assert(!(httpDecode != null && converter != null),
      'httpDecode和converter不能同时赋值，请删除一个');
  return await _execute(
    path,
    'DELETE',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    httpDecode: httpDecode,
    converter: converter,
    decodeType: decodeType,
  );
}

/// Handy method to make http PATCH request, which is a alias of  [dio.fetch(RequestOptions)].
/// decodeType 为空返回原始数据
Future<Result<K>> patch<T extends BaseNetModel, K>(
  String path, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
  NetDecoder? httpDecode,
  NetConverter<K>? converter,
  T? decodeType,
}) async {
  assert(!(httpDecode != null && converter != null),
      'httpDecode和converter不能同时赋值，请删除一个');
  return await _execute(
    path,
    'PATCH',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
    httpDecode: httpDecode,
    converter: converter,
    decodeType: decodeType,
  );
}

/// {@template dio.Dio.download}
Future<Response> download(
  String urlPath,
  dynamic savePath, {
  ProgressCallback? onReceiveProgress,
  Map<String, dynamic>? queryParameters,
  CancelToken? cancelToken,
  bool deleteOnError = true,
  String lengthHeader = Headers.contentLengthHeader,
  Object? data,
  Options? options,
}) async {
  return await NetOptions.instance.dio.download(
    urlPath,
    savePath,
    onReceiveProgress: onReceiveProgress,
    queryParameters: queryParameters,
    cancelToken: cancelToken,
    deleteOnError: deleteOnError,
    lengthHeader: lengthHeader,
    data: data,
    options: options,
  );
}

/// This method invokes the [cancel()] method on either the input
/// [cancelToken] or internal [_cancelToken] to pre-maturely end all
/// requests attached to this token.
void cancelRequests({CancelToken? cancelToken}) {
  cancelToken?.cancel();
}

/// A method to make http request, which is a alias of  [dio.fetch(RequestOptions)].
Future<Result<K>> _execute<T extends BaseNetModel, K>(
  String path,
  String method, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
  NetDecoder? httpDecode,
  NetConverter<K>? converter,
  T? decodeType,
}) async {
  if (!await NetworkConnectivity.connected) {
    return const Result.failure(msg: '网络未连接');
  }
  try {
    final response = await NetOptions.instance.dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options),
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
    if (decodeType == null) {
      return Result.success(response.data as K);
    } else if (converter != null) {
      return await compute(converter, response);
    } else {
      var decode = await compute(
          _mapCompute<T, K>,
          _MapBean<T>(response, decodeType,
              httpDecode ?? NetOptions.instance.httpDecoder));
      return Result.success(decode);
    }
  } on DioError catch (diorError) {
    if (kDebugMode) print("$path => DioError${diorError.message}");
    return Result.failure(
        msg: diorError.message ?? '',
        code: diorError.response?.statusCode ?? -1);
  } on NetException catch (e) {
    if (kDebugMode) print("$path => NetException${e.toString()}");
    return Result.failure(msg: e.message, code: e.code);
  } on TypeError catch (e) {
    if (kDebugMode) print("$path => TypeError${e.toString()}");
    return Result.failure(msg: e.toString());
  }
}

Options _checkOptions(String method, Options? options) {
  options ??= Options();
  options.method = method;
  return options;
}

/// A method to decode the response. use isolate
K _mapCompute<T extends BaseNetModel, K>(_MapBean<T> bean) {
  return bean.httpDecode
      .decode(response: bean.response, decodeType: bean.decodeType);
}

/// `_MapBean` is a class that is used to pass parameters to the isolate.
class _MapBean<T> {
  final Response<dynamic> response;
  final T decodeType;
  final NetDecoder httpDecode;

  _MapBean(this.response, this.decodeType, this.httpDecode);
}
