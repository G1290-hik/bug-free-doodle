import 'package:flutter/material.dart';

class AdapterRowWidget extends StatelessWidget {
  const AdapterRowWidget({
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width/2,
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
