import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';

part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel(
      {required int uId,
      required String title,
      required String desc,
      required int sectionId}) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
