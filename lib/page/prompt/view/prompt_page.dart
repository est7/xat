import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/page/prompt/state_provider/prompt_page_state.dart';

import '../state_provider/prompt_viewmodel.dart';

class PromptPage extends ConsumerStatefulWidget {
  const PromptPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PromptPageState();
}

class _PromptPageState extends ConsumerState<PromptPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(promptViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("List")),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(PromptState state) {
    return state.when(
      initial: () => const Center(child: Text('No data')),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (prompts) => ListView.builder(
        itemCount: prompts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(prompts[index].userId.toString()),
            subtitle: Text('Age: ${prompts[index].title.toString()}'),
          );
        },
      ),
      loadedWithError: (message) => Center(child: Text('Error: $message')),
    );
  }

  @override
  void initState() {
    super.initState();
    //确保这些操作在首帧绘制后再开始。
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //只有当你需要调用 StateNotifier 中的方法（如 refreshData()）时，才需要使用 .notifier。
      // 在大部分情况下，你应该尽量避免使用它，因为它会使你的代码变得难以测试。
      ref.read(promptViewModelProvider.notifier).refreshData();
    });
  }
}
