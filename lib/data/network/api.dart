//http://jsonplaceholder.typicode.com/posts?_page=1

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpUtil {

  BaseOptions options;

  // 私有构造函数
  HttpUtil._privateConstructor() {
    // 在这里进行初始化操作
    // 例如，设置 someConfig 变量
    options = "Initialized";
  }

  static HttpUtil instance;
  Dio dio;


  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    return instance;
  }

  /*
   * config it and create
   */
  HttpUtil() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Api.BASE_URL,
      //连接服务器超时时间，单位是秒.
      connectTimeout: const Duration(seconds: 10),
      //响应流上前后两次接受到数据的间隔，单位为秒。
      receiveTimeout: const Duration(seconds: 5),
      //Http请求头.
      headers: {
        //do something
        "version": "1.0.0"
      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.formUrlEncodedContentType,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.plain,
    );

    dio = Dio(options);

    //Cookie管理 // First request, and save cookies (CookieManager do it). but 好像没生效嘛...
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    //添加拦截器
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      print("请求之前 header = ${options.headers.toString()}");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(options); //continue
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      print("响应之前");
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      print("错误之前");
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      return handler.next(e);
    }));
  }

  //get方式获取
  Future get(String url, {Map<String, dynamic>? params}) async {
    Response response;
    try {
      response = await _dioClient.get(url,
          queryParameters: params, cancelToken: cancelToken);
    } on DioException catch (e) {
      formatError(e);
      rethrow;
    }
    return response.data;
  }

  //post 方式
  Future post(String url, {Map<String, dynamic>? params}) async {
    Response response;
    try {
      response =
          await _dioClient.post(url, data: params, cancelToken: cancelToken);
    } on DioException catch (e) {
      formatError(e);

      rethrow;
    }
    return response.data;
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /*
   * error统一处理
   */
  void formatError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      // It occurs when url is opened timeout.
      if (kDebugMode) {
        print("Dio:connectionTimeout==连接超时: ${e.message}");
      }
    } else if (e.type == DioExceptionType.sendTimeout) {
      // It occurs when url is sent timeout.
      if (kDebugMode) {
        print("Dio:sendTimeout==请求超时: ${e.message}");
      }
    } else if (e.type == DioExceptionType.receiveTimeout) {
      //It occurs when receiving timeout
      if (kDebugMode) {
        print("Dio:receiveTimeout==响应超时: ${e.message}");
      }
    } else if (e.type == DioExceptionType.connectionError) {
      // When the server response, but with a incorrect status, such as 404, 503...
      if (kDebugMode) {
        print("Dio:connectionError==出现异常: ${e.message}");
      }
    } else if (e.type == DioExceptionType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      if (kDebugMode) {
        print("Dio:cancel==请求取消: ${e.message}");
      }
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      if (kDebugMode) {
        print("Dio:DEFAULT==未知错误: ${e.message}");
      }
    }
  }
}
