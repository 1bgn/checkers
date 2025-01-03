import 'package:flutter/material.dart';

class EmojiRow extends StatefulWidget {
  final Function(String) selectEmoji;

  const EmojiRow({super.key, required this.selectEmoji});

  @override
  State<EmojiRow> createState() => _EmojiRowState();
}

class _EmojiRowState extends State<EmojiRow> {
  final List<String> emojies = ["👋","😺","😸","😹","😼","😽","🫶","🙀","😿","😾","🤔","🫣","🌚"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: emojies.map((e)=>InkWell(onTap: (){
              widget.selectEmoji(e);
            },child: EmojiItem(title: e))).toList(),
          ),
        ))
      ],
    );
  }
}
class EmojiItem extends StatelessWidget{
  final String title;

  const EmojiItem({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(fontSize: 46),);
  }
  
}
