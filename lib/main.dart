import 'core/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:githubissues/core/presentation/app.dart';

Future<void> main() async {
  await bootstrap();
  runApp(App());
}
