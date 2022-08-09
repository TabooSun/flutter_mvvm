import 'package:example/views/command_usage/command_usage.dart';
import 'package:example/views/command_usage/command_usage_view_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static BuildContext? fallbackContext;

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        fallbackContext = context;
        if (child == null) {
          return const SizedBox.shrink();
        }
        return child;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CommandUsageViewModel vm = CommandUsageViewModel();

  @override
  Widget build(BuildContext context) {
    return CommandUsageView(vm);
  }
}
