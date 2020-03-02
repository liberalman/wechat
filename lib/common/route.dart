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

Future<dynamic> routePushAndRemove(Widget widget) {
  final route = new CupertinoPageRoute(
    builder: (BuildContext context) => widget,
    settings: new RouteSettings(
      name: widget.toStringShort(),
      isInitialRoute: false,
    ),
  );
  return navGK.currentState.pushAndRemoveUntil(route, (route) => route == null);
}

popToRootPage() {
  navGK.currentState.popUntil(ModalRoute.withName('/'));
}

popToHomePage() {
  navGK.currentState.maybePop();
  navGK.currentState.maybePop();
  navGK.currentState.maybePop();
}