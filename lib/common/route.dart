import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final navGK = new GlobalKey<NavigatorState>(); // 导航

Future<dynamic> routePush(Widget widget) {
  final route = new CupertinoPageRoute(
    builder: (BuildContext context) => widget,
    settings: new RouteSettings(
      name: widget.toStringShort(),
      isInitialRoute: false,
    )
  );
  return navGK.currentState.push(route);
}