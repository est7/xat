//https://github.com/TesteurManiak/temopedia/blob/dev/lib/core/mixins/app_bar_size.dart
import 'package:flutter/material.dart';

mixin AppBarSize on Widget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}