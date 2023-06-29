// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'TMDB_KEY', obfuscate: true)
  static final tmdbApiKey = _Env.tmdbApiKey;
  @EnviedField(varName: 'KEY1')
  static const key1 = _Env.key1;
  @EnviedField()
  static const KEY2 = _Env.KEY2;
  @EnviedField(defaultValue: 'test_')
  static const key3 = _Env.key3;
}