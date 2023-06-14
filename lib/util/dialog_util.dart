import 'package:flash/flash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import '../router/root_router.dart';

void showModalFlash({String title = '', String? content}) {
  rootNavigatorKey.currentContext!.showModalFlash(
      builder: (context, controller) => FlashBar(
          controller: controller,
          behavior: FlashBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            side: BorderSide(
              color: Colors.yellow,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          margin: const EdgeInsets.all(32.0),
          clipBehavior: Clip.antiAlias,
          indicatorColor: Colors.amber,
          icon: const Icon(Icons.tips_and_updates_outlined),
          title: Text(title),
          content: Text(content ?? 'this is a basic content')));
}
