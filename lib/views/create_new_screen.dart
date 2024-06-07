import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsivev2/model/flash_card_model.dart';
import 'package:responsivev2/model/stack_model.dart';

import '../widgets/widgets.dart';

class CreateNewStackScreen extends StatefulWidget {
  final String? stackName; // Accept stack name as a parameter

  const CreateNewStackScreen({super.key, this.stackName});

  @override
  _CreateNewStackScreenState createState() => _CreateNewStackScreenState();
}

class _CreateNewStackScreenState extends State<CreateNewStackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _stackNameController = TextEditingController();
  final List<Map<String, String>> _flashcards = [];
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill stack name if provided
    if (widget.stackName != null) {
      _stackNameController.text = widget.stackName!;
      _stackNameController..text = widget.stackName!..selection = TextSelection.fromPosition(TextPosition(offset: widget.stackName!.length));
    }
  }

  void _addFlashcard() {
    if (_questionController.text.isNotEmpty && _answerController.text.isNotEmpty) {
      setState(() {
        _flashcards.add({
          'question': _questionController.text,
          'answer': _answerController.text,
        });
        _questionController.clear();
        _answerController.clear();
      });
    }
  }

  Future<void> _saveStack() async {
    if (_formKey.currentState!.validate()) {
      final box = await Hive.openBox<FlashcardStack>('flashcardStacks');
      final newStack = FlashcardStack(
        name: _stackNameController.text,
        cards: _flashcards.map((flashcard) {
          return Flashcard(
            question: flashcard['question']!,
            answer: flashcard['answer']!,
          );
        }).toList(),
      );
      box.add(newStack);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Stack'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
                TextFormField(
                  controller: _stackNameController,
                  decoration: const InputDecoration(labelText: 'Stack Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a stack name';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Question'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _answerController,
                decoration: const InputDecoration(labelText: 'Answer'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _addFlashcard,
                child: const Text('Add Flashcard'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _flashcards.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_flashcards[index]['question']!),
                      subtitle: Text(_flashcards[index]['answer']!),
                    );
                  },
                ),
              ),
              CustomButton(
                onPressed: _saveStack,
                label: 'Save Stack',
                  color:theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
