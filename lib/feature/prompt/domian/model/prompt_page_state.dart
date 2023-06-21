// Prompt States
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xat/model/prompt_model.dart';

part 'prompt_page_state.freezed.dart';

@freezed
abstract class PromptState with _$PromptState {
  const factory PromptState.initial() = PromptInitial;
  const factory PromptState.loading() = PromptLoading;
  const factory PromptState.loaded(List<PromptModel> prompts) = PromptsLoaded;
  const factory PromptState.loadedWithError(String message) = PromptsLoadedWithError;
}
