import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githubissues/features/issues/application/cubit/issues_cubit.dart';
import 'package:githubissues/features/issues/presentation/components/trailing_widget.dart';

import '../../domain/entities/issues.dart';

class IssuesWidget extends StatelessWidget {
  const IssuesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
      builder: (context, state) {
        log(state.issues.length.toString());
        if (state.isError != true) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                if (state.label != null) {
                  context.read<IssuesCubit>().fetchIssuesByLabel(state.label!);
                } else {
                  context.read<IssuesCubit>().fetchData();
                }
              }
              return true;
            },
            child: ListView.builder(
              itemCount: state.issues.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == state.issues.length && state.isLoading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (index == state.issues.length && !state.isLoading) {
                  return const SizedBox(
                    height: 100,
                  );
                } else {
                  Issue issue = state.issues[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Card(
                      child: ListTile(
                        titleTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
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
                                  .map(
                                    (label) => GestureDetector(
                                      onTap: () {
                                        if (state.label == null) {
                                          context
                                              .read<IssuesCubit>()
                                              .fetchIssuesByLabel(
                                                label.name,
                                              );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Please Remove Previous Query"),
                                            ),
                                          );
                                        }
                                      },
                                      child: Chip(
                                        label: Text(label.name),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        trailing: TrailingWidget(issue: issue),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else {
          return const Center(
            child: Text("Error Fetching Data"),
          );
        }
      },
    );
  }
}
