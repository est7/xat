//可以在其他地方重用 promptRepositoryProvider，
// 并且如果 PromptRepository 需要在初始化时接受一些参数，你只需要在一个地方修改即可。
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/repository_impl/chat_repository.dart';
import '../../../../data/repository_impl/prompt_repository.dart';

final promptRepositoryProvider = Provider<IPromptRepository>((ref) {
  return PromptRepository();
});

final chatRepositoryProvider = Provider<IChatRepository>((ref) {
  return ChatRepository();
});
