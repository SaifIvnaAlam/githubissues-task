import 'package:flutter/material.dart';
import 'package:githubissues/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/issues/application/cubit/issues_cubit.dart';
import 'package:githubissues/features/issues/presentation/issues_page.dart';
import 'package:githubissues/features/issues/domain/interface/i_Issues_repository.dart';

class App extends StatelessWidget {
  App({super.key});
  final IIssuesRespository _issueRepository = getIt<IIssuesRespository>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BlocProvider(
                create: (context) => IssuesCubit(_issueRepository),
                child: const IssuesPage(),
              ),
            ));
  }
}
