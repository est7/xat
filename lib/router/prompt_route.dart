import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../feature/prompt/presentation/view/prompt_detail_page.dart';
import '../feature/prompt/presentation/view/prompt_page.dart';
import '../generated/l10n.dart';

List<RouteBase> promptRoutes = <RouteBase>[
  GoRoute(
    path: '/prompt',
    builder: (BuildContext context, GoRouterState state) =>
        PromptPage(label: S.of(context).section_prompts),
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
