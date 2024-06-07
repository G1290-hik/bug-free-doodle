import 'package:flutter/material.dart';

class CreateCardScreen extends StatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final TextEditingController _cardTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cardTextController,
              decoration: InputDecoration(
                labelText: 'Card Text',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final cardText = _cardTextController.text;
                if (cardText.isNotEmpty) {
                  Navigator.pop(context, cardText);
                }
              },
              child: Text('Add Card'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardTextController.dispose();
    super.dispose();
  }
}
