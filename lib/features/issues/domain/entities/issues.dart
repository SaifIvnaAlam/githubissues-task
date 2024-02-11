import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:githubissues/features/issues/domain/entities/label.dart';
import 'package:githubissues/features/issues/domain/entities/users.dart';

// ignore_for_file: invalid_annotation_target

part 'issues.freezed.dart';
part 'issues.g.dart';

@freezed
class Issue with _$Issue {
  const factory Issue({
    required String title,
    String? body,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required User user,
    required List<Label> labels,
  }) = _Issue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}
