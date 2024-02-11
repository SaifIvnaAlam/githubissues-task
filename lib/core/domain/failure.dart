import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure({
    required int errorCode,
    required String message,
  }) = _Failure;

  factory Failure.none() => const Failure(
        errorCode: 0,
        message: '',
      );
}
