import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../domain/entities/issues.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:githubissues/features/issues/domain/interface/i_issues_repository.dart';

// ignore_for_file: no_leading_underscores_for_local_identifiers

part 'issues_cubit.freezed.dart';
part 'issues_state.dart';

@injectable
class IssuesCubit extends Cubit<IssuesState> {
  final IIssuesRespository _repo;
  IssuesCubit(this._repo) : super(IssuesState.loading());
  int page = 1;
  int labelPage = 1;

  Future<void> fetchData() async {
    try {
      List<Issue> issues = [];
      issues.addAll(state.issues);
      emit(state.copyWith(
        isLoading: true,
      ));
      var _result = await _repo.fetchIssues(page: page++);
      issues.addAll(_result);
      emit(
        state.copyWith(isLoading: false, issues: issues),
      );
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
  }

  Future<void> fetchIssuesByLabel(String label) async {
    try {
      List<Issue> issues = [];
      log("Printing Label $label");
      if (labelPage == 1) {
        emit(state.copyWith(issues: issues));
      }

      issues.addAll(state.issues);
      emit(state.copyWith(isLoading: true, label: label));
      final _issueByLabel =
          await _repo.fetchIssuesByLabel(label, page: labelPage++);

      issues.addAll(_issueByLabel);
      emit(
        state.copyWith(
          isLoading: false,
          issues: issues,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
  }

  Future<void> removeLabel() async {
    log("Removing Label");

    emit(state.copyWith(isLoading: true, issues: [], label: null));
    labelPage = 1;
    page = 1;
  }
}
