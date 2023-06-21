//http://jsonplaceholder.typicode.com/posts?_page=1
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'API.dart';

class _Http {
  // 创建一个静态变量，用于存储单例对象
  //私有属性,不能被在外调用
  static late final _Http _singleton;

  // 创建一个工厂方法，返回单例对象
  factory _Http() {
    if (_singleton == null) {
      _singleton = _Http._internal();
    }
    return _singleton;
  }

  late Dio _dioClient;
  late BaseOptions _options;

  // 创建一个内部构造方法，这样可以防止外部直接创建对象
  _Http._internal() {
    // 进行初始化配置
    _singleton._options = BaseOptions(
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

    _dioClient = Dio(_options);
    //Cookie管理 // First request, and save cookies (CookieManager do it). but 好像没生效嘛...
    // final cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));

    //添加拦截器
    _dioClient.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      if (kDebugMode) {
        print("请求之前 header = ${options.headers.toString()}");
      }
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(options); //continue
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      if (kDebugMode) {
        print("响应之前");
      }
      // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
      return handler.next(response); // continue
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      if (kDebugMode) {
        print("错误之前");
      }
      // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
      return handler.next(e);
    }));
  }

//get方式获取
  Future rawGet(String url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _dioClient.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
    } on DioException catch (e) {
      formatError(e);
      rethrow;
    }
    return response.data;
  }

//post 方式
  Future rawPost(String url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _dioClient.post(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
    } on DioException catch (e) {
      formatError(e);
      rethrow;
    }
    return response.data;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await _dioClient.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        if (kDebugMode) {
          print("$count $total");
        }
      });
      if (kDebugMode) {
        print('downloadFile success---------${response.data}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('downloadFile error---------$e');
      }
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
