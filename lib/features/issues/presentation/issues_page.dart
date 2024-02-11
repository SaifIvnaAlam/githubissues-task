import 'package:flutter/material.dart';
import 'components/issues_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githubissues/features/issues/application/cubit/issues_cubit.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<IssuesCubit>().fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<IssuesCubit, IssuesState>(
                    builder: (context, state) {
                      if (state.label != null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.label ?? ""),
                            GestureDetector(
                                onTap: () {
                                  context
                                      .read<IssuesCubit>()
                                      .removeLabel()
                                      .then((value) => context
                                          .read<IssuesCubit>()
                                          .fetchData());
                                },
                                child: const Icon(
                                    Icons.disabled_by_default_outlined))
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("Click on label to Fliter"),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            const Expanded(child: IssuesWidget()),
          ],
        ),
      ),
    );
  }
}
