import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/page/prompt/state_provider/prompt_page_state.dart';

import '../../../model/prompt_model.dart';
import '../../../provider/repository_provider.dart';
import 'prompt_usecase.dart';

class PromptViewModel extends StateNotifier<PromptState> {
  final InitPromptListUsecase initPromptListUsecase;
  final LoadMorePromptUsecase loadMorePromptUsecase;

  PromptViewModel({
    required this.initPromptListUsecase,
    required this.loadMorePromptUsecase,
  }) : super(const PromptInitial());

  Future<void> refreshData() async {
    state = const PromptLoading();
    try {
      final result = await initPromptListUsecase.call();
      result.when(
        success: (data) => state = PromptsLoaded(data),
        failure: (msg, code) => state = PromptsLoadedWithError(msg),
      );
    } catch (e) {
      state = PromptsLoadedWithError( e.toString());
    }
  }

  Future<void> loadMoreData() async {
    List<PromptModel> preState = [];

    // 获取先前的状态
    if (state is PromptsLoaded) {
      preState = (state as PromptsLoaded).prompts;
    }

    state = const PromptLoading();
    try {
      final result = await initPromptListUsecase.call();
      result.when(
        success: (data) => state = PromptsLoaded([...preState, ...data]),
        failure: (msg, code) => state = PromptsLoadedWithError(msg),
      );
    } catch (e) {
      state = PromptsLoadedWithError(e.toString());
    }
  }
}

final promptViewModelProvider =
    StateNotifierProvider<PromptViewModel, PromptState>((ref) {
  final promptRepository = ref.read(promptRepositoryProvider);
  return PromptViewModel(
      initPromptListUsecase:
          InitPromptListUsecase(repository: promptRepository),
      loadMorePromptUsecase:
          LoadMorePromptUsecase(repository: promptRepository));
});
