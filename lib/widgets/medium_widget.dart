import 'package:flutter/material.dart';
import 'package:responsivev2/widgets/compact_widget.dart';
class MediumWidget extends StatelessWidget {
  const MediumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Row(children: [
          CompactWidget(),
          Container(height: constraints.maxHeight,width: constraints.maxWidth,decoration: BoxDecoration(boxShadow:[BoxShadow(color: Colors.black),] ,),child: const CompactWidget()),
        ]
        );
      }
    );
  }
}
