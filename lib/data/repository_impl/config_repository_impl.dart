import 'package:xat/lib/net/flutter_net.dart';
import 'package:xat/model/prompt_model.dart';

abstract class IConfigRepository {
  Future<Result<List<PromptModel>>> getConfig();
}

//有的接口比较特殊，比如返回的数据格式是特殊的，需要单独解析，
// 此时有两种方法实现，第一种适合多个相同的特殊接口，
// 自定义针对这种数据格式的解析器，在请求时传入即可；
// 第二种适合单独出现的数据格式，通过回调方法在其中自行解析。
/*
class ConfigRepository implements IConfigRepository {
  @override
  Future<Result<List<PromptModel>>> getConfig() async {
    var appResponse = await get<Taskmodel, List<Taskmodel>>("banner/json",
        decodeType: BannerModel(), converter: customConverter);
    return appResponse;
  }
}

Result<List<dynamic>> customConverter(response) {
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
}

void method() {
  appResponse.when(success: (List<BannerBean> model) {
    debugPrint("成功返回${model.length}条");
  }, failure: (String msg, int code) {
    debugPrint("失败了：msg=$msg/code=$code");
  });
}
*/
