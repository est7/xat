import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:xat/widgets/scaffold_with_nav_bar.dart';

import '../page/prompt/view/prompt_page.dart';
import 'chat_route.dart';
import 'prompt_route.dart';
import 'setting_route.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _sectionChatTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionChatTab');

final GlobalKey<NavigatorState> _sectionPromptTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionPromptTab');

final GlobalKey<NavigatorState> _sectionSettingTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionSettingTab');

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/chat',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        //返回实现自定义shell的widget（在本例中使用BottomNavigationBar）。
        // StatefulNavigationShell被传递以能够访问shell的状态并以有状态的方式导航到其他branches。
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _sectionChatTabNavigatorKey,
          routes: chatRoute,
        ),

        StatefulShellBranch(
          //如果其他地方不需要navigatorKey，就没有必要提供它。如果没有提供，将使用一个默认的键。
          navigatorKey: _sectionPromptTabNavigatorKey,
          routes: promptRoutes,
        ),

        // The route branch for the third tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _sectionSettingTabNavigatorKey,
          routes: settingRoute,
        ),
      ],
    ),
  ],
);
