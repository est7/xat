import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/page/prompt/state_provider/prompt_page_state.dart';

import '../state_provider/prompt_viewmodel.dart';

class PromptPage extends ConsumerWidget {
  const PromptPage({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(promptListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("List")),
      body: _buildBody(state),
    );
  }

  _buildBody(PromptState state) {
    state.when(
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
}
