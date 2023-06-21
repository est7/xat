import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../const/constants_language.dart';
import '../../../../generated/l10n.dart';
import '../viewmodels/language_setting_viewmodel.dart';

/// 语言设置
class LanguageSettingListWidget extends ConsumerWidget {
  const LanguageSettingListWidget({super.key});

  final _languageConfig = languageConfigList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageViewState = ref.watch(intlStateProvider);
    final languageViewModel = ref.read(intlStateProvider.notifier);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        RadioListTile(
          value: languageViewState.followSystemLanguage,
          // specify the value here
          groupValue: true,
          title: Text(
            S.of(context).app_setting_language_system,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
          ),
          onChanged: (value) {
            if (!languageViewState.followSystemLanguage) {
              languageViewModel.setFollowSystemLanguage(true);
            }
          },
        ),
        ...List<Widget>.generate(_languageConfig.length, (index) {
          return RadioListTile(
            value: _languageConfig[index]["language"],
            groupValue: languageViewState.followSystemLanguage
                ? false
                : languageViewState.currentLanguageString,
            title: Text(
              _languageConfig[index]["language"].toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
            ),
            onChanged: (value) async {
              languageViewModel.setLanguage(value.toString());
              Navigator.pop(context);
              // handle the value change
            },
          );
        }),
      ],
    );
  }
}
