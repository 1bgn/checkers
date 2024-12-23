import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextRow extends StatefulWidget {
  final Function(String) selectText;

  const TextRow({super.key, required this.selectText});

  @override
  State<TextRow> createState() => _TextRowState();
}

class _TextRowState extends State<TextRow> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        borderSide: BorderSide(color: Colors.brown));
    return Row(
      children: [
        Expanded(
            child: TextFormField(
              textAlign: TextAlign.center,
          decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 12),border: border,enabledBorder: border,focusedBorder: border),
          controller: controller,
          onFieldSubmitted: (t) {
            widget.selectText(t);
            controller.clear();
          },
        ))
      ],
    );
  }
}
