import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../config/const.dart';

class ComMomBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showShadow; // 是否显示阴影
  final String title;
  final Widget titleW;
  final Color backgroundColor;
  final Color mainColor;
  final Widget leadingW;
  final PreferredSizeWidget bottom;
  final String leadingImg;
  final List<Widget> rightDMActions;

  const ComMomBar(
      {this.title = '',
      this.showShadow = false,
      this.rightDMActions,
      this.backgroundColor = appBarColor,
      this.mainColor = Colors.black,
      this.titleW,
      this.bottom,
      this.leadingImg = '',
      this.leadingW});

  @override
  Size get preferredSize => new Size(100.0, 50.0); // preferred	较喜欢; 喜欢…多于…;

  Widget leading(BuildContext context) {
    final bool isShow = Navigator.canPop(context);
    if (isShow) {
      return new InkWell(
        child: new Container(
          width: 15,
          height: 28,
          child: leadingImg != ''
              ? new Image.asset(leadingImg)
              : new Icon(CupertinoIcons.back, color: mainColor),
        ),
        onTap: () {
          if (Navigator.canPop(context)) {
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.pop(context);
          }
        },
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return showShadow
        ? new Container( // 显示阴影
            decoration: BoxDecoration(
                border: Border(
                    bottom: new BorderSide(
                        color: Colors.grey, width: showShadow ? 0.5 : 0.0))),
            child: new AppBar(
              title: titleW == null
                  ? new Text(
                      title,
                      style: new TextStyle(
                          color: mainColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    )
                  : titleW,
              backgroundColor: mainColor,
              elevation: 0.0,
              brightness: Brightness.light,
              leading: leadingW ?? leading(context),
              centerTitle: true,
              actions: rightDMActions ?? [new Center()],
              bottom: bottom != null ? bottom : null,
            ))
        : new AppBar( // 无阴影
            title: titleW == null
                ? new Text(
                    title,
                    style: new TextStyle(
                        color: mainColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500),
                  )
                : titleW,
            backgroundColor: backgroundColor,
            elevation: 0.0,
            // 高度; (尤指) 海拔
            brightness: Brightness.light,
            // 亮度
            leading: leadingW ?? leading(context),
            centerTitle: false,
            bottom: bottom != null ? bottom : null,
            actions: rightDMActions ?? [new Center()]);
  }
}
