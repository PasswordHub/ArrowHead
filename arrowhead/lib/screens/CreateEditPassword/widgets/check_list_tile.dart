import 'package:flutter/material.dart';

class CheckListTile extends StatelessWidget {
  final bool isCheck;
  final String text;

  const CheckListTile({Key? key, required this.text, required this.isCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        leading: isCheck
            ? const Icon(
                Icons.check,
                color: Colors.green,
              )
            : const Icon(
                Icons.close,
                color: Colors.red,
              ),
        contentPadding: const EdgeInsets.all(0),
        title: Text(text));
  }
}
