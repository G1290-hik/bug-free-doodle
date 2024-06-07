import 'package:hive/hive.dart';

import 'flash_card_model.dart';

part 'stack_model.g.dart';

@HiveType(typeId: 1)
class FlashcardStack extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Flashcard> cards;

  FlashcardStack({required this.name, required this.cards});
}
