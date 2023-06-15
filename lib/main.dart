import 'dart:math';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xat/data/network/init_net.dart';
import 'package:xat/model/app_config_model.dart';
import 'generated/l10n.dart';
import 'provider/root_provider.dart';
import 'page/settings/state_provider/theme_provider.dart';
import 'router/root_router.dart';

void main() {
  init();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> init() async {
  initNetConfig();
  // initAppConfig();
}

Future<void> initAppConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cacheDir = (await getApplicationDocumentsDirectory()).path;
  Hive.init(cacheDir);
  Hive.registerAdapter(AppConfigAdapter());
  var appConfigBox = await Hive.openBox<AppConfig>('appConfig');
  var appConfig = appConfigBox.get(0, defaultValue: AppConfig());

  final container = ProviderContainer();
  final themeState = container.read(themeStateProvider.notifier);
  themeState.initAppThemeConfig(appConfig!);
  container.dispose();
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeStateProvider);

    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      //使用 flutter_localizations 和 flutter_gen 生成的本地化委托 S.delegate 时，
      // 你可以使用 S.delegate.supportedLocales，它将自动包含所有你已经定义过的本地化文件的语言环境。
      // 因此，你不需要手动定义 supportedLocales。
      // supportedLocales: const [
      //   Locale('en', ''), // English
      //   Locale('zh', ''), // Chinese
      //   Locale('es', ''), //西班牙语
      // ],
      title: 'Xat',
      routerConfig: router,
      builder: (context, child) {
        child = Toast(navigatorKey: rootNavigatorKey, child: child!);
        return child;
      },
      //theme: 该参数用于指定应用的亮色主题，这个主题会被应用到应用的各个部分，例如按钮，文本等。
      // darkTheme: 该参数用于指定应用的暗色主题。当系统处于暗色模式时（例如，用户在系统设置中选择了暗色模式），应用会自动切换到这个暗色主题。
      // themeMode: 这是一个枚举参数，有三个值可以选择：
      // ThemeMode.system，ThemeMode.light和ThemeMode.dark。该参数用于控制应用应该使用亮色主题还是暗色主题。
      // 如果设置为ThemeMode.system，那么应用会跟随系统设置自动切换主题。
      // 如果设置为ThemeMode.light或ThemeMode.dark，那么应用会一直使用亮色主题或暗色主题，不会随系统设置改变。
      // 在大多数情况下，你可以在theme和darkTheme中分别设置亮色和暗色主题，然后将themeMode设置为ThemeMode.system，
      // 这样应用就可以根据系统设置自动切换主题了。如果你希望应用始终使用某一种主题，那么可以将themeMode设置为ThemeMode.light或ThemeMode.dark。
      darkTheme:
          theme.followSystemTheme ? theme.darkThemeData : theme.customThemeData,
      themeMode: theme.followSystemTheme ? ThemeMode.system : ThemeMode.light,
      theme: theme.followSystemTheme
          ? theme.lightThemeData
          : theme.customThemeData,
      // theme: ThemeData.light().copyWith(
      //     extensions: [const FlashToastTheme(), const FlashBarTheme()]),
    );
  }
}
