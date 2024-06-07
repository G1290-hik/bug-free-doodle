import 'package:flutter/material.dart';
import 'list_card.dart';

class CompactWidget extends StatelessWidget {
  const CompactWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return ListCard(text: 'Example ${index + 1}');
        },
        childCount: 20,
      ),
    );
  }
}
