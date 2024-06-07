import 'package:flutter/material.dart';
import 'package:responsivev2/views/cards_view.dart';

class ListCard extends StatefulWidget {
  const ListCard({super.key, required this.text});
  final String text;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardView(
              stackName: widget.text,
            ),
          ),
        );
      },
      child: Card(
        color: theme.colorScheme.onTertiary,
        shadowColor: Colors.black,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.album),
                title: Text(
                  widget.text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
