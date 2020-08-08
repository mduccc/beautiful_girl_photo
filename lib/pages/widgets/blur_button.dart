import 'package:flutter/material.dart';

class BlurButton extends StatelessWidget {
  final Key key;
  final Icon child;
  final double opacity;
  final Function onPressed;

  BlurButton(
      {@required this.child, this.key, this.opacity = 0.2, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Container(
            width: 35,
            height: 35,
            padding: EdgeInsets.zero,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(opacity), shape: BoxShape.circle),
            child: child),
      );
}
