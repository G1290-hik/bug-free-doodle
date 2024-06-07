import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'package:responsivev2/model/model.dart';
import 'package:responsivev2/views/views.dart';
import '../widgets/widgets.dart';

class CardView extends StatefulWidget {
  const CardView({
    super.key,
    required this.stackName,
  });

  final String stackName;

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> with SingleTickerProviderStateMixin {
  late List<CardState> _cardStates = [];
  int _currentIndex = 0;
  int _totalCards = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _initializeCardStates();
  }

  Future<void> _initializeCardStates() async {
    final box = await Hive.openBox<FlashcardStack>('flashcardStacks');
    final stack = box.values.firstWhereOrNull((stack) => stack.name == widget.stackName);

    if (stack != null) {
      setState(() {
        _cardStates = stack.cards
            .map((card) => CardState(showFrontSide: true, flipXAxis: false, flashCard: card))
            .toList();
        _totalCards = stack.cards.length;
      });
    } else {
      setState(() {
        _cardStates = [];
        _totalCards = 0;
      });
    }

    _currentIndex = 0; // Reset the current index whenever we initialize the card states
  }

  void _switchCard() {
    if (_cardStates.isNotEmpty) {
      setState(() {
        _cardStates[_currentIndex].showFrontSide = !_cardStates[_currentIndex].showFrontSide;
      });
      _animationController.forward(from: 0);
    }
  }

  void _discardCard(int index) {
    setState(() {
      _cardStates.removeAt(index);
      if (_currentIndex >= _cardStates.length) {
        _currentIndex = _cardStates.length - 1;
      } else if (_currentIndex < 0) {
        _currentIndex = 0;
      }
    });
  }

  void _resetDeck() {
    _initializeCardStates();
  }
  double _calculateProgress() {
    if (_cardStates.isEmpty) {
      return 1.0; // All cards have been viewed
    }
    return (_currentIndex + 1) /
        _cardStates.length; // Progress based on the number of cards
  }

  Future<void> _navigateToAddCardScreen(BuildContext context) async {
    final newCard = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardsToStackScreen(stackName: widget.stackName),
      ),
    );

    if (newCard != null && newCard is Flashcard) {
      final box = await Hive.openBox<FlashcardStack>('flashcardStacks');
      final stack = box.values.firstWhereOrNull((stack) => stack.name == widget.stackName);
      if (stack != null) {
        setState(() {
          stack.cards.add(newCard);
          box.put(stack.key, stack); // Save updated stack back to Hive
          _cardStates.add(CardState(showFrontSide: true, flipXAxis: false, flashCard: newCard));
          _totalCards++;
          _currentIndex = _cardStates.length - 1; // Move to the newly added card
        });
      }
    }
  }
  void _nextCard() {
    if (_currentIndex < _totalCards - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = _calculateProgress();

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        title: Text(
          widget.stackName,
          style: TextStyle(color: theme.colorScheme.surface),
        ),
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetDeck,
            icon: const Icon(Icons.restart_alt_sharp),
            color: theme.iconTheme.color,
          ),
          IconButton(
            onPressed: () => _navigateToAddCardScreen(context),
            icon: const Icon(Icons.add),
            color: theme.iconTheme.color,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //:TODO Learn how to fix this
            // SizedBox(
            //   height: 10,
            //   child: LinearProgressIndicator(
            //     value: progress,
            //     backgroundColor: theme.colorScheme.surface,
            //     color: theme.colorScheme.secondary,
            //   ),
            // ),
            // const SizedBox(width: 10),
            Expanded(
              child: _cardStates.isEmpty
                  ? Center(
                child: Text(
                  'End of Cards',
                  style: TextStyle(
                    color: theme.colorScheme.surface,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : CardStack(
                cardStates: _cardStates,
                discardCard: _discardCard,
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              onPressed: _switchCard,
              label: 'Reveal',
              color: theme.buttonTheme.colorScheme!.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
