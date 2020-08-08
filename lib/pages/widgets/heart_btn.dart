import 'package:beautiful_girl_photo/custom_icon_icons.dart';
import 'package:beautiful_girl_photo/pages/widgets/blur_button.dart';
import 'package:flutter/material.dart';

class HeartBtn extends StatefulWidget {
  final bool hasSelected;

  HeartBtn({this.hasSelected = false});

  @override
  _HeartBtnState createState() => _HeartBtnState();
}

class _HeartBtnState extends State<HeartBtn> {
  bool _hasSelected;

  @override
  void initState() {
    super.initState();
    _hasSelected = widget.hasSelected;
  }

  @override
  Widget build(BuildContext context) => BlurButton(
        child: Icon(
          _hasSelected ? CustomIcon.heart : CustomIcon.heart_empty,
          color: Colors.pinkAccent,
          size: 27,
        ),
        opacity: 0,
        onPressed: () {
          _hasSelected = !_hasSelected;
          setState(() {});
        },
      );

  @override
  void didUpdateWidget(HeartBtn oldWidget) {
    super.didUpdateWidget(oldWidget);
    _hasSelected = widget.hasSelected;
  }
}
