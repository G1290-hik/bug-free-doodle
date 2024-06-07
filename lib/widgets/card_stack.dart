import 'package:flutter/material.dart';
import 'package:responsivev2/model/flash_card_model.dart';
import 'package:responsivev2/widgets/flash_card_widget.dart';


class CardState {
  bool showFrontSide;
  bool flipXAxis;
  Flashcard flashCard;

  CardState({
    required this.showFrontSide,
    required this.flipXAxis,
    required this.flashCard,
  });
}
class CardStack extends StatelessWidget {
  final List<CardState> cardStates;
  final Function(int) discardCard;

  const CardStack({
    required this.cardStates,
    required this.discardCard,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      cardStates.length,
          (index) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10 * index.toDouble()),
            child: Draggable<int>(
              data: index,
              feedback: Material(
                type: MaterialType.transparency,
                child: Transform.scale(
                  scale: 1.05,
                  child: FlippableCard(
                    flipXAxis: cardStates[index].flipXAxis,
                    showFrontSide: cardStates[index].showFrontSide,
                    onFlip: () {
                      _flipCard(index, context);
                    },
                    backtext: cardStates[index].flashCard.answer,
                    frontext: cardStates[index].flashCard.question,
                  ),
                ),
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                if (details.offset.dx > MediaQuery.of(context).size.width ||
                    details.offset.dx < 0 ||
                    details.offset.dy > MediaQuery.of(context).size.height ||
                    details.offset.dy < 0) {
                  discardCard(index);
                }
              },
              child: FlippableCard(
                flipXAxis: cardStates[index].flipXAxis,
                showFrontSide: cardStates[index].showFrontSide,
                onFlip: () {
                  _flipCard(index, context);
                },
                backtext: cardStates[index].flashCard.answer,
                frontext: cardStates[index].flashCard.question,
              ),
            ),
          ),
        );
      },
    );
    cards = cards.reversed.toList();
    return Stack(children: cards);
  }

  void _flipCard(int index, BuildContext context) {
    cardStates[index].showFrontSide = !cardStates[index].showFrontSide;
    (context as Element).markNeedsBuild();
  }
}
