import 'package:flutter/material.dart';
import 'package:responsivev2/utility/utility.dart';
import 'package:responsivev2/views/views.dart';


void main() {
  runApp(const FlaschCardApp());
}

class FlaschCardApp extends StatefulWidget {
  const FlaschCardApp({super.key});

  @override
  State<FlaschCardApp> createState() => _FlaschCardAppState();
}

class _FlaschCardAppState extends State<FlaschCardApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Tinos", "Tinos");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flasch Card App',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: CardView(),
    );
  }
}
