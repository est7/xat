import 'package:flutter/cupertino.dart';
import 'package:xat/lib/net/flutter_net.dart';
import 'package:xat/lib/net/src/net_client.dart';
import 'package:xat/model/prompt_model.dart';

import '../network/API.dart';
import '../network/my_http_decoder.dart';

abstract class IPromptRepository {
  Future<Result<List<PromptModel>>> getLocalPromptList();

  Future<Result<List<PromptModel>>> getNetWorkPromptList(num page);
}

class PromptRepository implements IPromptRepository {
  @override
  Future<Result<List<PromptModel>>> getLocalPromptList() {
    return Future.value(null);
  }

  /**
   *
      appResponse.when(success: (List<PromptModel> entity) {
      var size = entity.length;
      debugPrint("成功返回$size条");
      return entity;
      }, failure: (String msg, int code) {
      debugPrint("失败了：msg=$msg/code=$code");
      return <PromptModel>[]; // 在失败时返回一个空列表
      });
   */
  @override
  Future<Result<List<PromptModel>>> getNetWorkPromptList(num page) async {
    var appResponse = await get<PromptModel, List<PromptModel>>(
        Api.PROMPT_LIST,
        decodeType: const PromptModel());

    return Future.value(appResponse);
  }
}
