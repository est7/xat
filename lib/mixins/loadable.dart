// https: //github.com/TesteurManiak/temopedia/blob/dev/lib/core/mixins/loadable.dart
import 'dart:async';

mixin Loadable on Object {
  FutureOr<void> load();
}
