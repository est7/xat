import 'package:flutter/cupertino.dart';

import '../../lib/net/flutter_net.dart';
import '../../lib/net/src/base_net_model.dart';
import '../../lib/net/src/net_decoder.dart';

/// 默认解码器
class MyHttpDecoder extends NetDecoder {
  /// 单例对象
  static final MyHttpDecoder _instance = MyHttpDecoder._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  MyHttpDecoder._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory MyHttpDecoder.getInstance() => _instance;

  @override
  K decode<T extends BaseNetModel, K>(
      {required Response<dynamic> response, required T decodeType}) {
    var errorCode = response.data['errorCode'];

    /// 请求成功
    if (errorCode == 0) {
      var data = response.data['data'];
      if (data is List) {
        var dataList = List<T>.from(data
            .map((item) => callFromJsonIfPresent(decodeType, item))
            .toList()) as K;
        return dataList;
      } else {
        var model = callFromJsonIfPresent(decodeType, response.data) as K;
        return model;
      }
    } else {
      var errorMsg = response.data['errorMsg'];
      throw NetException(errorMsg, errorCode);
    }
  }

  dynamic callFromJsonIfPresent(dynamic object, Map<String, dynamic> json) {
    try {
      final result = object.fromJson(json);
      return result;
    } on NoSuchMethodError catch (e) {
      debugPrint("Your Model must have fromJson method");
      rethrow;
    } catch (e) {
      return null;
    }
  }
}
