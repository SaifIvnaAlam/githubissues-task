import 'package:githubissues/features/issues/domain/entities/issues.dart';

abstract class IIssuesRespository {
  Future<List<Issue>> fetchIssues({int page = 1});
  Future<List<Issue>> fetchIssuesByLabel(String labelQuery, {int page = 1});
}
