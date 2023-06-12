import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'base_viewmodel.dart';

abstract class BaseState<T extends StatefulWidget, M extends BaseViewModel>
    extends State<T> {
  late M viewModel;
  late String pageName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return build(context);
  }

  Widget initView() {
    return Consumer(
      builder: (context, ref, child) {
        return viewModel.isLoading ? buildLoadingWidget() : buildView();
      },
    );
  }

  Widget buildView();

  Widget buildLoadingWidget();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies: ${pageName}界面");
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget: ${pageName}界面");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate:${pageName}界面");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose 离开${pageName}界面");
    print("销毁${pageName}界面");
  }
}
