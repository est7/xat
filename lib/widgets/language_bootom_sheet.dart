import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 底部详情内容弹出
Future<T?> showModalBottomDetail<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    barrierColor: Colors.black45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.w),
        topRight: Radius.circular(32.w),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            Semantics(
              button: true,
              label: "返回",
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                key: const Key("widget_move_modal_bottom_sheet"),
                margin: EdgeInsets.all(12.w),
                height: 4.w,
                width: 24.w,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                ),
              ),
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      );
    },
  );
}
