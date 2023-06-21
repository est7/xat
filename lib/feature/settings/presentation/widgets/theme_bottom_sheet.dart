import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../view/application_setting_page.dart';


class ThemeBottomSheet extends StatelessWidget {
  final WidgetRef ref;
  final List<ThemeItemModel> themeList;
  final bool Function(BuildContext, WidgetRef,int, ThemeItemModel) buildTrailing;

  const ThemeBottomSheet({
    Key? key,
    required this.ref,
    required this.themeList,
    required this.buildTrailing,
  }) : super(key: key);

  ListTile mapListTile(
      BuildContext context, WidgetRef ref, int index, ThemeItemModel model) {
    return ListTile(
      leading: Icon(model.icon),
      title: Text(model.text),
      trailing:
          buildTrailing(context, ref,index, model) ? const Icon(Icons.check) : null,
      onTap: () {
        model.onTap(context, ref, index, model);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return Wrap(
          children: themeList.asMap().entries.map((entry) {
        var index = entry.key;
        var model = entry.value;
        return mapListTile(context, ref, index, model);
      }).toList());
    });
  }
}
