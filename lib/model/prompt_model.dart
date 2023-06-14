import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xat/lib/net/flutter_net.dart';

part 'prompt_model.freezed.dart';

part 'prompt_model.g.dart';

@freezed
class PromptModel with BaseNetModel , _$PromptModel {
  const PromptModel._(); // Added constructor
  const factory PromptModel({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) = _PromptModel;

  factory PromptModel.fromJson(Map<String, dynamic> json) =>
      _$PromptModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) {
    return _$PromptModelFromJson(json);
  }
}
