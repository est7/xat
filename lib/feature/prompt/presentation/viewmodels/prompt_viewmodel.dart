import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/prompt_model.dart';
import '../../../chat/domian/repository/chat_repository.dart';
import '../../domian/model/prompt_page_state.dart';
import '../../domian/repository/prompt_repository.dart';
import '../../domian/usecase/prompt_usecase.dart';

class PromptViewModel extends StateNotifier<PromptState> {
  final InitPromptListUsecase _initPromptListUsecase;
  final LoadMorePromptUsecase _loadMorePromptUsecase;
  num _page = 1;

  PromptViewModel({
    required InitPromptListUsecase initPromptListUsecase,
    required LoadMorePromptUsecase loadMorePromptUsecase,
  })  : _loadMorePromptUsecase = loadMorePromptUsecase,
        _initPromptListUsecase = initPromptListUsecase,
        super(const PromptInitial());

  Future<void> refreshData() async {
    _page = 1;
    state = const PromptLoading();
    try {
      final result = await _initPromptListUsecase();
      result.when(
        success: (data) => state = PromptsLoaded(data),
        failure: (msg, code) => state = PromptsLoadedWithError(msg),
      );
    } catch (e) {
      state = PromptsLoadedWithError(e.toString());
    }
  }

  Future<void> loadMoreData() async {
    List<PromptModel> preState = [];

    // 获取先前的状态
    if (state is PromptsLoaded) {
      preState = (state as PromptsLoaded).prompts;
    }
    // state = const PromptLoading();
    try {
      _page++;
      final result = await _loadMorePromptUsecase(_page);
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
