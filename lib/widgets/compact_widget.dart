import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsivev2/model/stack_model.dart';

import 'list_card.dart';

class CompactWidget extends StatelessWidget {
  const CompactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<FlashcardStack>('flashcardStacks'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Center(child: Text(snapshot.error.toString())),
            );
          } else {
            final box = Hive.box<FlashcardStack>('flashcardStacks');
            return ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Box<FlashcardStack> box, _) {
                if (box.values.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No flashcard stacks available')),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final flashcardStack = box.getAt(index);
                      return ListCard(
                        text: flashcardStack?.name ?? 'No name',
                      );
                      //,Cards: ${flashcardStack?.cards.length ?? 0}
                    },
                    childCount: box.length,
                  ),
                );
              },
            );
          }
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
