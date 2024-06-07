import 'package:flutter/material.dart';
import 'package:responsivev2/views/create_new_card_view.dart';
import 'package:responsivev2/widgets/card_stack.dart';
import 'package:responsivev2/widgets/custom_button_widget.dart';

class CardView extends StatefulWidget {
  const CardView({
    this.title,
    super.key,
  });

  final String? title;

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> with SingleTickerProviderStateMixin {
  late List<CardState> _cardStates;
  int _currentIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeCardStates();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _initializeCardStates() {
    _cardStates = List.generate(
      10,
          (index) => CardState(showFrontSide: true, flipXAxis: false),
    );
    _currentIndex = 0; // Reset the current index whenever we initialize the card states
  }

  void _switchCard() {
    if (_cardStates.isNotEmpty) {
      setState(() {
        _cardStates[_cardStates.length - 1].showFrontSide =
        !_cardStates[_cardStates.length - 1].showFrontSide;
      });
      _animationController.forward(from: 0);
    }
  }

  void _discardCard(int index) {
    setState(() {
      _cardStates.removeAt(index);
      if (_currentIndex >= _cardStates.length) {
        _currentIndex = _cardStates.length - 1;
      } else {
        _currentIndex++;
      }
    });
  }

  void _resetDeck() {
    setState(() {
      _initializeCardStates();
    });
  }

  double _calculateProgress() {
    if (_cardStates.isEmpty) {
      return 1.0; // All cards have been viewed
    }
    return (_currentIndex + 1) / 10; // Assuming the deck always starts with 10 cards
  }
  Future<void> _navigateToCreateCardScreen(BuildContext context) async {
    final newCardText = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateCardScreen()),
    );

    if (newCardText != null && newCardText is String) {
      setState(() {
        _cardStates.add(CardState(showFrontSide: true, flipXAxis: false));
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
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: theme.colorScheme.primary,
        // title: Text(
        //   widget.title.toString(),
        //   style: const TextStyle(fontWeight: FontWeight.bold),
        // ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetDeck,
            icon: const Icon(Icons.redo),
            color: theme.iconTheme.color,
          ),
          IconButton(
            onPressed: () => _navigateToCreateCardScreen(context),
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
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: theme.colorScheme.surface,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${(_currentIndex + 1).toString()}/10', // Always show out of 10
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
