import 'package:flutter/material.dart';

class Adapter_Row_Widget extends StatelessWidget {
  const Adapter_Row_Widget({
    super.key,
    required this.theme,
    required this.width,
    this.subtitle,
    required this.iconColor,
    required this.title,
    required this.icon,
    required this.align,
  });

  final ThemeData theme;
  final String? subtitle;
  final String title;
  final double width;
  final IconData icon;
  final Color iconColor;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: theme.colorScheme.secondary,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
          title: Column(
            crossAxisAlignment: align,
            children: [
              CircleAvatar(
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(color: theme.colorScheme.onTertiary),
                )
              : null,
        ),
      ),
    );
  }
}
