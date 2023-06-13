import 'package:freezed_annotation/freezed_annotation.dart';

import '../lib/net/src/base_net_model.dart';

part 'prompt_model.freezed.dart';

part 'prompt_model.g.dart';

@freezed
class PromptModel  with  MyJsonSerializable<PromptModel>, _$PromptModel {
  const factory PromptModel({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) = _PromptModel;

  factory PromptModel.fromJson(Map<String, dynamic> json) =>
      _$PromptModelFromJson(json);

  @override
  PromptModel fromMyJson(Map<String, dynamic> json) {
    // TODO: implement fromMyJson
    throw UnimplementedError();
  }

}
