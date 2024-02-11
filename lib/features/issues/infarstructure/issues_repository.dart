import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../domain/entities/issues.dart';
import '../domain/interface/i_Issues_repository.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

String _baseUrl = 'https://api.github.com/repos/flutter/flutter';
String _token = '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';
int _perPage = 7;

@LazySingleton(as: IIssuesRespository)
class IssuesRepository implements IIssuesRespository {
  IssuesRepository();

  @override
  Future<List<Issue>> fetchIssues({int page = 1}) async {
    var response = await http.get(
      Uri.parse("$_baseUrl/issues?per_page=$_perPage&page=$page"),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );
    if (response.statusCode == 200) {
      log("reponse Found");
      final List<dynamic> issuesJson = jsonDecode(response.body);
      final List<Issue> issues =
          issuesJson.map((issue) => Issue.fromJson(issue)).toList();

      return issues;
    } else {
      throw Exception('Failed to fetch issues');
    }
  }

  @override
  Future<List<Issue>> fetchIssuesByLabel(String label, {int page = 1}) async {
    try {
      final url =
          '$_baseUrl/issues?labels=$label&per_page=$_perPage&page=$page';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      log('${response.body}, response body');

      if (response.statusCode == 200) {
        final List<dynamic> issuesJson = jsonDecode(response.body);
        final List<Issue> issues =
            issuesJson.map((issue) => Issue.fromJson(issue)).toList();
        return issues;
      } else {
        throw const SocketException("Unable to load data By label");
      }
    } catch (e) {
      log('Error during API call: $e, EndPoint: GET');
      throw const SocketException("Unable to load data By label");
    }
  }
}