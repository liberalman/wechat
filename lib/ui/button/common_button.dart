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
  final bool enable;
  final Gradient gradient; // 变化率
  final List<BoxShadow> boxShadow; // 盒子边缘的阴影
  final bool isBorder; // 是否显示边框
  final int borderColor; // 边框颜色
  final double radius; // 边缘棱角处的弧度

  ComMomButton({
    this.width,
    this.height = 40.0,
    this.boxShadow,
    this.radius = 5.0,
    this.text = 'button',
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 5.0),
    this.margin,
    this.style,
    this.color,
    this.isBorder = false,
    this.gradient = const LinearGradient(
      colors: [
        Color.fromRGBO(8, 191, 98, 1.0),
        Color.fromRGBO(8, 191, 98, 1.0),
      ],
    ),
    this.enable = true,
    this.borderColor = 0xffFC6973,
  });

  @override
  Widget build(BuildContext context) {
    Color _color = Color.fromRGBO(255, 255, 255, enable ? 1 : 0.3);

    return new Container(
      margin: margin,
      child: new InkWell(
        child: new Container(
          alignment: Alignment.center,
          padding: padding,
          width: width,
          height: height,
          child: new Text('$text', style: null != style ? style : TextStyle(fontSize: 15.0, color: _color),),
          decoration: color == null
              ? BoxDecoration(
            gradient: gradient,
            boxShadow: boxShadow,
            border: isBorder
                ? Border.all(width: 0.5, color: Color(borderColor))
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          )
              : BoxDecoration(
            color: color,
            boxShadow: boxShadow,
            border: isBorder
                ? Border.all(width: 0.5, color: Color(borderColor))
                : null,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
        onTap: enable ? onTap : () {}
      ),
    );
  }
}