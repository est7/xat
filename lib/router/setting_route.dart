import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:xat/page/settings/view/application_setting_page.dart';

import '../generated/l10n.dart';
import '../page/settings/view/azure_setting_page.dart';
import '../page/settings/view/chat_setting_page.dart';
import '../page/settings/view/openai_setting_page.dart';
import '../page/settings/view/settings_page.dart';

List<RouteBase> settingRoute = <RouteBase>[
  GoRoute(
    path: '/settings',
    builder: (BuildContext context, GoRouterState state) => SettingsPage(
      label: S.of(context).section_setting,
      detailsPath: '/settings/openai_setting',
    ),
    routes: <RouteBase>[
      GoRoute(
        path: 'openai_setting',
        builder: (BuildContext context, GoRouterState state) =>
            OpenaiSettingPage(
          label: 'openai_setting',
          extra: state.extra,
          withScaffold: false,
        ),
      ),
      GoRoute(
        path: 'azure_setting',
        builder: (BuildContext context, GoRouterState state) =>
            AzureSettingPage(
          label: 'azure_setting',
          extra: state.extra,
        ),
      ),
      GoRoute(
        path: 'chat_setting',
        builder: (BuildContext context, GoRouterState state) => ChatSettingPage(
          label: 'chat_setting',
          extra: state.extra,
        ),
      ),
      GoRoute(
        path: 'application_setting',
        builder: (BuildContext context, GoRouterState state) =>
            ApplicationSettingPage(
          label: 'application_setting',
          extra: state.extra,
        ),
      )
    ],
  ),
];
