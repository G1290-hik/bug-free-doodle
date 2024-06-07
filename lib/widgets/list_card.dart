import 'package:flutter/material.dart';
class ListCard extends StatefulWidget {
  const ListCard({super.key, required this.text});
  final String text;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Card(
      color: theme.colorScheme.onTertiary,
      shadowColor: Colors.black,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.album),
              title: Text(
                widget.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(icon:const Icon(Icons.more_vert) ,onPressed: (){

              },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Button'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  child: const Text('Button 1'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
