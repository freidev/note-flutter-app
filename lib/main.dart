import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note/screens/home.dart';
import 'package:note/utils/styles.dart';

void main() {
  runApp(const ProviderScope(child: NoteApp()));
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note app',
      theme: theme,
      home: const Home(),
    );
  }
}
