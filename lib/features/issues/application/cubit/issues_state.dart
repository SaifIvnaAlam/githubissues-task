part of 'issues_cubit.dart';

@freezed
class IssuesState with _$IssuesState {
  const factory IssuesState({
    required bool isLoading,
    required List<Issue> issues,
    String? label,
    bool? isError,
  }) = _IssuesState;
  factory IssuesState.loading() => const IssuesState(
        isLoading: true,
        issues: [],
      );
}
