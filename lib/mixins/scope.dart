import 'dart:async';

extension Let<T> on T? {
  R? let<R>(R Function(T value) cb) {
    if (this == null) return null;
    return cb(this as T);
  }
}

extension LetAsync<T> on Future<T?> {
  Future<R> letAsync<R>(FutureOr<R> Function(T) block) async {
    final value = await this;
    if (value == null) {
      throw Exception('Value is null');
    }
    return block(value);
  }
}

extension Also<T> on T {
  /// Calls the specified function [block] with `this` value as its argument
  /// and returns `this` value.
  T also(void Function(T) block) {
    block(this);

    return this;
  }
}

extension AlsoAsync<T> on Future<T> {
  Future<T> alsoAsync(FutureOr<void> Function(T) block) async {
    final value = await this;
    await block(value);

    return value;
  }
}
