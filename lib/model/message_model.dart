import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';

part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel(
      {required int uId,
      required String content,
      required bool isUser,
      required DateTime timestamp}) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
