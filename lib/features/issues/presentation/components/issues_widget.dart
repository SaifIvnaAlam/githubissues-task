import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githubissues/features/issues/application/cubit/issues_cubit.dart';
import 'package:githubissues/features/issues/presentation/components/issue_card.dart';

import '../../domain/entities/issues.dart';

class IssuesWidget extends StatelessWidget {
  const IssuesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
      builder: (context, state) {
        if (state.isError != true) {
          return issues(state, context);
        } else {
          return const Center(
            child: Text("Error Fetching Data"),
          );
        }
      },
    );
  }

  NotificationListener<ScrollNotification> issues(
      IssuesState state, BuildContext context) {
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
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (index == state.issues.length && !state.isLoading) {
            return const SizedBox(
              height: 100,
            );
          } else {
            Issue issue = state.issues[index];
            return IssueCard(
              issue: issue,
              state: state,
            );
          }
        },
      ),
    );
  }
}
