import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:xat/page/chat/chat_detail_page.dart';
import 'package:xat/page/chat/chat_page.dart';
import 'package:xat/page/prompt/prompt_detail_page.dart';
import 'package:xat/page/prompt/prompt_page.dart';
import 'package:xat/page/settings/azure_setting_page.dart';
import 'package:xat/page/settings/chat_setting_page.dart';
import 'package:xat/page/settings/settings_page.dart';
import 'package:xat/widgets/scaffold_with_nav_bar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
          navigatorKey: _sectionANavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              //在底部导航栏的第一个标签中作为根显示的屏幕。
              path: '/chat',
              builder: (BuildContext context, GoRouterState state) =>
                  const ChatPage(label: 'chat', detailsPath: '/chat/detail'),
              routes: <RouteBase>[
                //显示在第一个标签的导航器上的细节屏幕堆叠。
                // 这将覆盖屏幕A，但不包括应用程序外壳(application shell)（底部导航栏）。
                GoRoute(
                  path: 'detail',
                  builder: (BuildContext context, GoRouterState state) =>
                      const ChatDetailPage(label: 'chat_detail'),
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          //如果其他地方不需要navigatorKey，就没有必要提供它。如果没有提供，将使用一个默认的键。
          routes: <RouteBase>[
            GoRoute(
              path: '/prompt',
              builder: (BuildContext context, GoRouterState state) =>
                  const PromptPage(
                label: 'prompt',
                detailsPath: '/prompt/prompt_detail',
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: 'prompt_detail',
                  builder: (BuildContext context, GoRouterState state) =>
                      PromptDetailPage(
                    label: 'prompt_detail',
                    param: state.pathParameters['param'],
                  ),
                ),
              ],
            ),
          ],
        ),

        // The route branch for the third tab of the bottom navigation bar.
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/settings',
              builder: (BuildContext context, GoRouterState state) =>
                  const SettingsPage(
                label: 'settings',
                detailsPath: '/settings/openai_setting',
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: 'openai_setting',
                  builder: (BuildContext context, GoRouterState state) =>
                      AzureSettingPage(
                    label: 'openai_setting',
                    extra: state.extra,
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
                  builder: (BuildContext context, GoRouterState state) =>
                      ChatSettingPage(
                    label: 'chat_setting',
                    extra: state.extra,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
