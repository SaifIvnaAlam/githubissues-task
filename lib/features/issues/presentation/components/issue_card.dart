import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githubissues/features/issues/application/cubit/issues_cubit.dart';
import 'package:githubissues/features/issues/domain/entities/issues.dart';
import 'package:githubissues/features/issues/presentation/components/trailing_widget.dart';

class IssueCard extends StatelessWidget {
  const IssueCard({super.key, required this.issue, required this.state});

  final Issue issue;
  final IssuesState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        child: ListTile(
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          title: Text(issue.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  issue.body != null
                      ? issue.body!.split('\n').first
                      : 'No body Found',
                  style: const TextStyle(fontSize: 14.0)),
              Wrap(
                spacing: 8.0,
                children: issue.labels
                    .map((label) => GestureDetector(
                          onTap: () {
                            if (state.label == null) {
                              context
                                  .read<IssuesCubit>()
                                  .fetchIssuesByLabel(label.name);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please Remove Previous Query"),
                                ),
                              );
                            }
                          },
                          child: Chip(
                            label: Text(label.name),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          trailing: TrailingWidget(issue: issue),
        ),
      ),
    );
  }
}
