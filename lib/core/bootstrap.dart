import 'package:flutter/material.dart';
import 'package:githubissues/injection.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
}
