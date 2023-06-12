import 'package:xat/model/prompt_bean.dart';

abstract class IPromptRepository {
  Future<List<Map>> getPromptList();
}

class PromptRepository implements IPromptRepository {
  @override
  Future<List<Map>> getPromptList() async {
    return [
      {
        "id": 1,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
      {
        "id": 2,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
      {
        "id": 3,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
      {
        "id": 4,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
      {
        "id": 5,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
      {
        "id": 6,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
      {
        "id": 7,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
      {
        "id": 8,
        "title": "title",
        "content": "content",
        "createTime": "createTime",
        "updateTime": "updateTime",
        "isDelete": 0,
      },
    ];
  }
}
