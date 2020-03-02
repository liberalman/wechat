import 'package:flutter/material.dart';

class ComMomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback onTap;
  final Color color;
  final TextStyle style;

  ComMomButton({
    this.width,
    this.height = 40.0,
    this.text = 'button',
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 5.0),
    this.margin,
    this.style,
    this.color,
});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container();
  }
}