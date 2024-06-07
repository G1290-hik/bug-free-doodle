import 'dart:math';

import 'package:flutter/material.dart';
class FlippableCard extends StatefulWidget {
  final bool flipXAxis;
  final bool showFrontSide;
  final Function() onFlip;
  final String backtext;
  final String frontext;

  const FlippableCard({
    super.key,
    required this.frontext,
    required this.backtext,
    required this.flipXAxis,
    required this.showFrontSide,
    required this.onFlip,
  });

  @override
  _FlippableCardState createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> {

  Widget __transitionBuilder(Widget card, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: card,
      builder: (context, child) {
        final isUnder = (ValueKey(widget.showFrontSide) != child!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
        isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: widget.flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }

  Widget _buildFront(String text, Color color) {
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: color,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(text, style: const TextStyle(fontSize: 50.0)),
      ),
    );
  }

  Widget _buildRear(String body, Color color) {
    return __buildLayout(
      key: const ValueKey(false),
      backgroundColor: color,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            body,
            style: const TextStyle(
              fontSize: 50.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget __buildLayout({
    required Key key,
    required Widget child,
    required Color backgroundColor,
  }) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Center(
        child: Stack(
          children: [
            Center(child: child),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    double newWidth;
    double wide() {
      if (width > 600) {
        newWidth = width * 0.7;
      } else {
        newWidth = width * 0.9;
      }
      return newWidth;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget card, Animation<double> animation) {
        return __transitionBuilder(card, animation);
      },
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return SizedBox(
          height: height * 0.5,
          width: wide(),
          child: Stack(
            children: [
              if (currentChild != null) currentChild,
              ...previousChildren,
            ],
          ),
        );
      },
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut.flipped,
      child: widget.showFrontSide
          ? _buildFront(widget.frontext, theme.colorScheme.onSecondary)
          : _buildRear(widget.backtext, theme.colorScheme.secondary),
    );
  }
}
