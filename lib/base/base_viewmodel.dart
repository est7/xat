import 'package:flutter/widgets.dart';

abstract class BaseViewModel with ChangeNotifier {
  BuildContext context;

  BaseViewModel(this.context);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    if (_isLoading != isLoading) {
      _isLoading = isLoading;
    }
    notifyListeners();
  }

  ///刷新数据
  @protected
  Future refreshData({bool isShowLoading = true});
}
