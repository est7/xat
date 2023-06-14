import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../page/prompt/view/prompt_detail_page.dart';
import '../page/prompt/view/prompt_page.dart';

List<RouteBase> promptRoutes = <RouteBase>[
  GoRoute(
    path: '/prompt',
    builder: (BuildContext context, GoRouterState state) => const PromptPage(),
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
];
