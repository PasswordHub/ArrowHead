import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final Function(String?)? onChanged;
  final Function(String?) onSaved;
  final String initialValue;
  const MyTextField(
      {Key? key,
      this.keyboardType = TextInputType.none,
      this.onChanged,
      required this.onSaved,
      this.initialValue = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        initialValue: initialValue,
        autocorrect: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: const Color.fromARGB(255, 220, 220, 220),
            filled: true),
        enableSuggestions: false,
        autofocus: false,
        keyboardType: keyboardType,
        maxLines: keyboardType == TextInputType.multiline ? 4 : 1,
        onChanged: onChanged,
        onSaved: onSaved,
      ),
    );
  }
}
