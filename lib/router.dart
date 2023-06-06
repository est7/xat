import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:xat/page/chat_page.dart';
import 'package:xat/page/detail_page.dart';
import 'package:xat/page/prompt_page.dart';
import 'package:xat/page/settings_page.dart';
import 'package:xat/widgets/ScaffoldWithNavBar.dart';

import 'page/root_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final pages = [
  GoRoute(path: '/chat_page', builder: (context, state) => const ChatPage()),
  GoRoute(
      path: '/prompt_page', builder: (context, state) => const PromptPage()),
  GoRoute(
      path: '/settings_page',
      builder: (context, state) => const SettingsPage()),
];

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/a',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        // Return the widget that implements the custom shell (in this case
        // using a BottomNavigationBar). The StatefulNavigationShell is passed
        // to be able access the state of the shell and to navigate to other
        // branches in a stateful way.
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the
              // bottom navigation bar.
              path: '/a',
              builder: (BuildContext context, GoRouterState state) =>
                  const RootScreen(label: 'A', detailsPath: '/a/details'),
              routes: <RouteBase>[
                // The details screen to display stacked on navigator of the
                // first tab. This will cover screen A but not the application
                // shell (bottom navigation bar).
                GoRoute(
                  path: 'details',
                  builder: (BuildContext context, GoRouterState state) =>
                      const DetailsScreen(label: 'A'),
                ),
              ],
            ),
          ],
        ),

        // The route branch for the second tab of the bottom navigation bar.
        StatefulShellBranch(
          // It's not necessary to provide a navigatorKey if it isn't also
          // needed elsewhere. If not provided, a default key will be used.
          routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
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
              // The screen to display as the root in the third tab of the
              // bottom navigation bar.
              path: '/c',
              builder: (BuildContext context, GoRouterState state) =>
                  const RootScreen(
                label: 'C',
                detailsPath: '/c/details',
              ),
              routes: <RouteBase>[
                GoRoute(
                  path: 'details',
                  builder: (BuildContext context, GoRouterState state) =>
                      DetailsScreen(
                    label: 'C',
                    extra: state.extra,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
