import 'dart:io';

import 'package:flutter_di23_courses/objectbox.g.dart';
import 'package:flutter_di23_courses/pages/home_page.dart';
import 'package:flutter_di23_courses/utils/global_vars.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory appPath = await getApplicationDocumentsDirectory();
  print(appPath.path);
  print(appPath.absolute.path);
  GlobalVars.store = await openStore(directory: "${appPath.path}/database/");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

