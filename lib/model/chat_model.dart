import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';


@freezed
class ChatModel with _$ChatModel {
  const ChatModel._();
  const factory ChatModel({
    int? uId,
    String? title,
    String? desc,
    int? sectionId
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

}
