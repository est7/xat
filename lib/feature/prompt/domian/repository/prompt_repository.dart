//可以在其他地方重用 promptRepositoryProvider，
// 并且如果 PromptRepository 需要在初始化时接受一些参数，你只需要在一个地方修改即可。
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../data/repository_impl/prompt_repository.dart';
import '../../../../lib/net/src/result.dart';
import '../../../../model/prompt_model.dart';

abstract class IPromptRepository {
  Future<Result<List<PromptModel>>> getLocalPromptList();

  Future<Result<List<PromptModel>>> getNetWorkPromptList(num page);
}

final promptRepositoryProvider = Provider<IPromptRepository>((ref) {
  return PromptRepository();
});
