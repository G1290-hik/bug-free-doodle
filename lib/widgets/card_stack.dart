import 'package:flutter/material.dart';
import 'package:responsivev2/widgets/flash_card_widget.dart';

class CardStack extends StatelessWidget {
  final List<CardState> cardStates;
  final Function(int) discardCard;

  const CardStack({
    required this.cardStates,
    required this.discardCard,
    Key? key,
  }) : super(key: key);

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
                    onFlip: () {},
                    backtext: 'Back ${index + 1}',
                    frontext: 'Front ${index + 1}',
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
                onFlip: () {},
                backtext: 'Back ${index + 1}',
                frontext: 'Front ${index + 1}',
              ),
            ),
          ),
        );
      },
    );

    return Stack(children: cards);
  }
}

class CardState {
  bool showFrontSide;
  bool flipXAxis;

  CardState({
    required this.showFrontSide,
    required this.flipXAxis,
  });
}
