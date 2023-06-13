import 'package:xat/data/network/API.dart';
import 'package:xat/lib/net/src/net_options.dart';
import 'my_http_decoder.dart';

void initNetConfig() {
  NetOptions.instance
      // header
      .addHeaders({"application": 'xat'})
      // baseUrl
      .setBaseUrl(Api.BASE_URL)
      // 代理/https
      // .setHttpClientAdapter(IOHttpClientAdapter()
      //   ..onHttpClientCreate = (client) {
      //     client.findProxy = (uri) {
      //       return 'PROXY 192.168.20.43:8888';
      //     };
      //     client.badCertificateCallback =
      //         (X509Certificate cert, String host, int port) => true;
      //     return client;
      //   })
      // cookie
      //    .addInterceptor(CookieManager(CookieJar()))
      // dio_http_cache
      // .addInterceptor(DioCacheManager(CacheConfig(
      //   baseUrl: "https://www.wanandroid.com/",
      // )).interceptor)
      // dio_cache_interceptor
      //     .addInterceptor(DioCacheInterceptor(
      //     options: CacheOptions(
      //       store: MemCacheStore(),
      //       policy: CachePolicy.forceCache,
      //       hitCacheOnErrorExcept: [401, 403],
      //       maxStale: const Duration(days: 7),
      //       priority: CachePriority.normal,
      //       cipher: null,
      //       keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      //       allowPostMethod: false,
      //     )))
//   全局解析器
//       .setHttpDecoder(MyHttpDecoder.getInstance())
      //  超时时间
      .setConnectTimeout(const Duration(milliseconds: 3000))
      // 允许打印log，默认未 true
      .enableLogger(true)
      .create();
}

/*/// Get 请求原始数据
void requestGet() async {
  var appResponse = await get("banner/json");
  appResponse.when(success: (dynamic) {
    // var size = model.data?.length;
    debugPrint("成功返回$dynamic");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}

/// Get 请求数据，不带泛型
void requestGet1() async {
  var appResponse = await get("banner/json", decodeType: BannerModel());
  appResponse.when(success: (model) {
    var size = model.data?.length;
    debugPrint("不带泛型成功返回$size条");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}

/// Get 请求数据，完整的泛型
void requestGet2() async {
  var appResponse = await get<BannerModel, BannerModel>("banner/json",
      decodeType: BannerModel());
  appResponse.when(success: (model) {
    var size = model.data?.length;
    debugPrint("成功返回$size条");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}

/// Post 请求
void requestPost() async {
  var appResponse = await post<UserWrapperModel, UserWrapperModel>(
      "user/login",
      decodeType: UserWrapperModel(),
      queryParameters: {"username": '你的账号', "password": '你的密码'});
  appResponse.when(success: (UserWrapperModel model) {
    var nickname = model.data?.nickname;
    debugPrint("成功返回nickname=$nickname");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}

/// 自定义Decoder的 Post 请求
void requestCustomDecoderPost() async {
  var appResponse = await post<UserModel, UserModel>("user/login",
      decodeType: UserModel(),
      httpDecode: MyHttpDecoder.getInstance(),
      queryParameters: {"username": '', "password": ''});
  appResponse.when(success: (UserModel model) {
    var nickname = model.nickname;
    debugPrint("成功返回nickname=$nickname");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}

/// 自定义Decoder的 Get 请求
void requestCustomGet() async {
  var appResponse = await get<BannerBean, List<BannerBean>>("banner/json",
      decodeType: BannerBean(), httpDecode: MyHttpDecoder.getInstance());
  appResponse.when(success: (List<BannerBean> model) {
    var size = model.length;
    debugPrint("成功返回$size条");
  }, failure: (String msg, int code) {
    debugPrint("失败了：$msg");
  });
}

/// 自定保存和携带 cookie 的请求
void requestCookieGet() async {
  var appResponse = await get<CollectModel, CollectModel>(
      "lg/collect/list/0/json",
      decodeType: CollectModel(),
      httpDecode: MyHttpDecoder.getInstance());
  appResponse.when(success: (CollectModel model) {
    var size = model.datas?.length;
    debugPrint("成功返回$size条");
  }, failure: (String msg, int code) {
    debugPrint("失败了：$msg");
  });
}

/// 带缓存的 Get 请求
void requestCacheGet() async {
  var appResponse = await get<BannerModel, BannerModel>("banner/json",
      options: buildCacheOptions(const Duration(days: 7)),
      decodeType: BannerModel());
  appResponse.when(success: (BannerModel model) {
    var size = model.data?.length;
    debugPrint("成功返回$size条");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}

/// 通过回调解析返回的请求
void requestCallBack() async {
  var appResponse = await get<BannerModel, List<BannerBean>>("banner/json",
      options: buildCacheOptions(const Duration(days: 7)),
      decodeType: BannerModel(), converter: (response) {
        var errorCode = response.data['errorCode'];

        /// 请求成功
        if (errorCode == 0) {
          var data = response.data['data'];
          var dataList = List<BannerBean>.from(
              data.map((item) => BannerBean.fromJson(item)).toList());
          return Result.success(dataList);
        } else {
          var errorMsg = response.data['errorMsg'];
          return Result.failure(msg: errorMsg, code: errorCode);
        }
      });
  appResponse.when(success: (List<BannerBean> model) {
    debugPrint("成功返回${model.length}条");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}*/
