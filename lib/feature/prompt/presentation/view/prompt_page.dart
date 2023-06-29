import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domian/model/prompt_page_state.dart';
import '../viewmodels/prompt_viewmodel.dart';

class PromptPage extends ConsumerStatefulWidget {
  const PromptPage({
    required this.label,
    super.key,
  });

  /// The label
  final String label;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PromptPageState();
}

class _PromptPageState extends ConsumerState<PromptPage> {
  late final ScrollController _scrollController = ScrollController();

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
      loaded: (prompts) => RefreshIndicator(
        onRefresh: () async {
          ref.read(promptViewModelProvider.notifier).refreshData();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: prompts.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prompts[index].title ?? '',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 10),
                    Text(
                      prompts[index].body ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 10),
                    Chip(
                      label: Text('User ID: ${prompts[index].userId}'),
                    ),
                    SizedBox(height: 10),
                    Chip(
                      label: Text('Post ID: ${prompts[index].id}'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Read More'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          ref.read(promptViewModelProvider.notifier).loadMoreData();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose;
  }
}
