import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../base/view_state.dart';


class OpenaiSettingState {
  final int counter;
  final ViewState viewState;

  OpenaiSettingState({required this.counter, required this.viewState});

  OpenaiSettingState.initial()
      : counter = 0,
        viewState = ViewState.idle;

  OpenaiSettingState copyWith({int? counter, ViewState? viewState}) {
    return OpenaiSettingState(
        counter: counter ?? this.counter,
        viewState: viewState ?? this.viewState);
  }
}

class OpenaiSettingViewModel extends StateNotifier<OpenaiSettingState> {
  OpenaiSettingViewModel() : super(OpenaiSettingState.initial());

  void increment() {
    state = state.copyWith(counter: state.counter + 1);
  }
}

/// 不加autoDispose,退出时不会清理状态
final openaiSettingProvider = StateNotifierProvider.autoDispose<
    OpenaiSettingViewModel,
    OpenaiSettingState>((ref) => OpenaiSettingViewModel());
