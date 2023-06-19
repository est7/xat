import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xat/page/settings/state_provider/language_setting_viewmodel.dart';
import '../const/constants_language.dart';
import '../generated/l10n.dart';

/// 语言设置
class LanguageSettingListWidget extends ConsumerWidget {
  const LanguageSettingListWidget({super.key});

  final _languageConfig = languageConfigList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageViewModel = ref.watch(intlStateProvider);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        RadioListTile(
          value: true, // specify the value here
          groupValue: true,
          title: Text(
            S.of(context).app_setting_language_system,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
          ),
          onChanged: (value) async {
            // handle the value change
          },
        ),
        ...List<Widget>.generate(_languageConfig.length, (index) {
          return RadioListTile(
            value: _languageConfig[index]["locale"].toString(),
            groupValue: languageViewModel.followSystemLanguage,
            title: Text(
              _languageConfig[index]["language"].toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
            ),
            onChanged: (value) async {
              // handle the value change
            },
          );
        }),
      ],
    );
  }
}
