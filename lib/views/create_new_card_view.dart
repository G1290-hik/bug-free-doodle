import 'package:flutter/material.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final TextEditingController _cardTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cardTextController,
              decoration: const InputDecoration(
                labelText: 'Card Text',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final cardText = _cardTextController.text;
                if (cardText.isNotEmpty) {
                  Navigator.pop(context, cardText);
                }
              },
              child: const Text('Add Card'),
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
