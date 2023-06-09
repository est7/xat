import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../feature/chat/presentation/view/chat_detail_page.dart';
import '../feature/chat/presentation/view/chat_page.dart';
import '../generated/l10n.dart';

List<RouteBase> chatRoute = <RouteBase>[
  GoRoute(
    //在底部导航栏的第一个标签中作为根显示的屏幕。
    path: '/chat',
    builder: (BuildContext context, GoRouterState state) => ChatPage(
        label: S.of(context).section_chat, detailsPath: '/chat/detail'),
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
];
