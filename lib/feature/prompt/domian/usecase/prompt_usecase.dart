import 'package:xat/model/prompt_model.dart';

import '../../../../data/repository_impl/prompt_repository.dart';
import '../../../../lib/net/src/result.dart';

class InitPromptListUsecase {
  final IPromptRepository repository;

  InitPromptListUsecase({required this.repository});

  Future<Result<List<PromptModel>>> call() {
    return repository.getNetWorkPromptList(1);
  }
}

class LoadMorePromptUsecase {
  final IPromptRepository repository;

  LoadMorePromptUsecase({required this.repository});

  Future<Result<List<PromptModel>>> call(num page) {
    return repository.getNetWorkPromptList(page);
  }
}
