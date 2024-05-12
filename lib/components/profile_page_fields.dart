// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final Icon icon;
  final String title;
  const ProfileField({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 40,
          width: 40,
          color: Colors.grey.shade200,
          child: icon,
        ),
      ),
      title: Text(title),
      trailing: InkWell(
        child: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}
