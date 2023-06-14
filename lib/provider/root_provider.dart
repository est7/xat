// 全局的provider
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xat/data/repository/prompt_repository.dart';

import '../core/log_util.dart';
import '../core/toast_util.dart';


final myLogger = MyLog();
final myToast = MyToast();


class Storage {
  String KEY = 'key';

  Future<bool> savePageValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(KEY, value);
  }

  Future<bool> getPageValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY) ?? false;
  }
}

// 语言状态提供器
final localeProvider = StateProvider<Locale>((ref) {
  return const Locale('en', 'US');
});