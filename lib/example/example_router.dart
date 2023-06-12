/*
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
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
  initialLocation: '/a',
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
              path: '/a',
              builder: (BuildContext context, GoRouterState state) =>
                  const RootScreen(label: 'A', detailsPath: '/a/details'),
              routes: <RouteBase>[
                //显示在第一个标签的导航器上的细节屏幕堆叠。
                // 这将覆盖屏幕A，但不包括应用程序外壳(application shell)（底部导航栏）。
                GoRoute(
                  path: 'details',
                  builder: (BuildContext context, GoRouterState state) =>
                      const DetailsScreen(label: 'A'),
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          //如果其他地方不需要navigatorKey，就没有必要提供它。如果没有提供，将使用一个默认的键。
          routes: <RouteBase>[
            GoRoute(
              path: '/b',
              builder: (BuildContext context, GoRouterState state) =>
                  const RootScreen(
                label: 'B',
                detailsPath: '/b/details/1',
                secondDetailsPath: '/b/details/2',
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: 'details/:param',
                  builder: (BuildContext context, GoRouterState state) =>
                      DetailsScreen(
                    label: 'B',
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
*/
