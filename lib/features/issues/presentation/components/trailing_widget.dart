import 'package:flutter/material.dart';
import 'package:githubissues/features/issues/domain/entities/issues.dart';

class TrailingWidget extends StatelessWidget {
  const TrailingWidget({
    super.key,
    required this.issue,
  });

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${issue.createdAt.day}/${issue.createdAt.month}/${issue.createdAt.year}',
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 4.0),
        Text(
          'By ${issue.user.login}',
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
