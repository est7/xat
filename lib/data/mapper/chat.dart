import 'package:drift/drift.dart';
import 'package:xat/model/chat_model.dart';

import '../entity/chat_entity.dart';

class ChatMapper {
  static ChatModel transformToModel(ChatEntity entity) {
    return ChatModel(
      uId: entity.id,
      title: entity.name,
      desc: entity.description,
      sectionId: entity.dueDate.hashCode,
    );
  }

  static List<ChatModel> transformToModelList(List<ChatEntity> entities) {
    return entities.map((e) => transformToModel(e)).toList();
  }
}

/*
class ChatConvertor extends TypeConverter<ChatModel, ChatEntity> {
  @override
  ChatModel fromSql(ChatEntity fromDb) {
    throw UnimplementedError();
  }

  @override
  ChatEntity toSql(ChatModel value) {
    throw UnimplementedError();
  }
}
*/
