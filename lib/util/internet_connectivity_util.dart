import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dialog_util.dart';


const String noConnection = "noConnection";
const String noConnectionMessage = "noConnectionMessage";

void checkInternetConnectivity(WidgetRef ref) {
  final connectivity = Connectivity();
  connectivity.onConnectivityChanged.listen((event) {
    switch (event) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        //eg:https://github.com/austinevick/flutter-mvvm/blob/main/lib/common/utils.dart
        // ref.invalidate(homeViewFutureProvider);
        break;
      case ConnectivityResult.none:
        showModalFlash(title: noConnection, content: noConnectionMessage);
        break;
      default:
        ConnectivityResult.mobile;
    }
  });
}

final internetNotifier = Provider((ref) => Connectivity());