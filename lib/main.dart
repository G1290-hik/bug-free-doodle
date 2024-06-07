import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsivev2/model/flash_card_model.dart';
import 'package:responsivev2/model/stack_model.dart';
import 'package:responsivev2/utility/utility.dart';
import 'package:responsivev2/views/views.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FlashcardAdapter());
  Hive.registerAdapter(FlashcardStackAdapter());
  //: Only Use when intiating on  a new device
  // // Open the boxes
  var flashcardStackBox = await Hive.openBox<FlashcardStack>('flashcardStacks');
  var flashcardBox = await Hive.openBox<Flashcard>('flashcards');

  // // Add initial data if boxes are empty
  if (flashcardStackBox.isEmpty && flashcardBox.isEmpty) {
    var flashcard1 = Flashcard(question: "What is Flutter?", answer: "A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.");
    var flashcard2 = Flashcard(question: "Who developed Flutter?", answer: "Google");

    var flashcardStack = FlashcardStack(name: "General Knowledge", cards: [flashcard1, flashcard2]);

    await flashcardBox.add(flashcard1);
    await flashcardBox.add(flashcard2);
    await flashcardStackBox.add(flashcardStack);
  }

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
      title: 'Flash Card App',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const SliverScreen(),
    );
  }
}
