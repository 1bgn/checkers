import 'package:flutter/cupertino.dart';

class EmojiScene extends StatefulWidget{
  final String content;
  final VoidCallback callback;

  const EmojiScene({super.key, required this.content, required this.callback});

  @override
  State<EmojiScene> createState() => _EmojiSceneState();
}

class _EmojiSceneState extends State<EmojiScene>  with SingleTickerProviderStateMixin{
  AnimationController? _controller;
  Animation? _tween;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,


      duration: const Duration(
        milliseconds: 1300,
      ),
    );
    _controller?.addListener(() {
      setState(() {});
    });
    _controller!.forward().then((v) async {
     await _controller!.reverse();
      widget.callback();
    });
    _tween = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: _controller!, curve: Curves.ease));


  }
  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Transform.rotate(
      angle: 30/360*_tween?.value,
      child: Padding(
        padding:  EdgeInsets.only(top: _controller?.value??0)*120,
        child: Text(widget.content,style: TextStyle(fontSize: ((_tween?.value*124)??0)),),
      ),
    );
  }
}