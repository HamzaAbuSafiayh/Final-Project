import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onTap; // Added required onTap field

  const ProfileField({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap, // Make onTap a required parameter
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: icon,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: theme.colorScheme.onSurface,
      ),
      onTap: onTap, // Attach the onTap callback here
    );
  }
}
