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
import 'appconfig/theme_state.dart';
import 'router/root_router.dart';

void main() {

  init();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> init() async {
  initNetConfig();
  initAppConfig();
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
  themeState.init(appConfig!);
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
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      theme: theme,
      // theme: ThemeData.light().copyWith(
      //     extensions: [const FlashToastTheme(), const FlashBarTheme()]),
    );
  }
}
