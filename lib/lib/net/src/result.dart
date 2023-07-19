import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T data) = Success;

  const factory Result.failure(
      {@Default('') String msg, @Default(-1) int code}) = Failure;

  T? get successOrNull => when(
        success: (s) => s,
        failure: (msg, code) => null,
      );

  Failure? get failureOrNull => when(
      success: (s) => null,
      failure: (msg, code) => Failure(msg: msg, code: code));

  Result<TResult> whenSuccess<TResult>(TResult Function(T) onSuccess) {
    return when(
        success: (s) => Result.success(onSuccess(s)),
        failure: (msg, code) => Failure(msg: msg, code: code));
  }
}

extension ResultDecoder<F extends Failure> on Result<Object?> {
  Result<S> decode<S>(S Function(Map<String, dynamic>) decoder) {
    return whenSuccess<S>((s) {
      final Map<String, dynamic> json;
      if (s is String) {
        json = jsonDecode(s) as Map<String, dynamic>;
      } else {
        json = s as Map<String, dynamic>;
      }
      return decoder(json);
    });
  }

  Result<List<S>> decodeList<S>(S Function(Map<String, dynamic>) decoder) {
    return whenSuccess(
      (s) {
        final List json;
        if (s is String) {
          json = jsonDecode(s) as List;
        } else {
          json = s as List;
        }

        return json
            .cast<Map<String, dynamic>>()
            .map((json) => decoder(json))
            .toList();
      },
    );
  }
}

extension FutureResultDecoder<F extends Failure> on Future<Result<Object?>> {
  Future<Result<S>> decode<S>(
    S Function(Map<String, dynamic>) decoder,
  ) async {
    return (await this).decode(decoder);
  }

  Future<Result<List<S>>> decodeList<S>(
    S Function(Map<String, dynamic>) decoder,
  ) async {
    return (await this).decodeList(decoder);
  }
}
