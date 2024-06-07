import 'package:flutter/material.dart';
import 'package:responsivev2/model/flash_card_model.dart';

class AddCardsToStackScreen extends StatefulWidget {
  final String stackName;

  const AddCardsToStackScreen({super.key, required this.stackName});

  @override
  _AddCardsToStackScreenState createState() => _AddCardsToStackScreenState();
}

class _AddCardsToStackScreenState extends State<AddCardsToStackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  Future<void> _addFlashcard() async {
    if (_formKey.currentState!.validate()) {
      final question = _questionController.text;
      final answer = _answerController.text;

      final newCard = Flashcard(question: question, answer: answer);

      Navigator.of(context).pop(newCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card to ${widget.stackName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _answerController,
                decoration: const InputDecoration(labelText: 'Answer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an answer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addFlashcard,
                child: const Text('Add Flashcard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
