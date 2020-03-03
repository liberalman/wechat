import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/route.dart';
import '../../common/check.dart';
import '../../generated/i18n.dart';
import '../contacts/group_launch_page.dart';
import '../home/search_page.dart';
import '../settings/language_page.dart';
import '../../ui/view/indicator_page_view.dart';
import '../more/add_friend_page.dart';
import '../../config/const.dart';
import '../../ui/w_pop/w_popup_menu.dart';
import '../../ui/bar/common_bar.dart';
import '../../ui/web/web_view.dart';

typedef CheckLogin(index);

class RootTabBar extends StatefulWidget {
  RootTabBar({this.pages, this.checkLogin, this.currentIndex = 0});

  final List pages;
  final CheckLogin checkLogin;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => new RootTabBarState();
}

class RootTabBarState extends State<RootTabBar> {
  var pages = new List<BottomNavigationBarItem>();
  int currentIndex;
  var contents = new List<Offstage>();
  PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    pageController = PageController(initialPage: currentIndex);
    for (int i = 0; i < widget.pages.length; i++) {
      TabBarModel model = widget.pages[i];
      pages.add(
        new BottomNavigationBarItem(
          icon: model.icon,
          activeIcon: model.selectIcon,
          title: new Text(model.title, style: new TextStyle(fontSize: 12.0)),
        ),
      );
    }
  }

  actionsHandle(v) {
    if (v == '添加朋友') {
      routePush(new AddFriendPage());
    } else if (v == '发起群聊') {
      routePush(new GroupLaunchPage());
    } else if (v == '帮助与反馈') {
      routePush(new WebViewPage(helpUrl, '帮助与反馈'));
    } else {
      routePush(new LanguagePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List actions = [
      {"title": '发起群聊', 'icon': 'assets/images/contacts_add_newmessage.png'},
      {"title": '添加朋友', 'icon': 'assets/images/ic_add_friend.webp'},
      {"title": '扫一扫', 'icon': ''},
      {"title": '收付款', 'icon': ''},
      {"title": '帮助与反馈', 'icon': ''},
    ];

    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: pages,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      fixedColor: Colors.green,
      unselectedItemColor: mainTextColor,
      onTap: (int index) {
        setState(() => currentIndex = index);
        pageController.jumpToPage(currentIndex);
      },
      unselectedFontSize: 18.0,
      selectedFontSize: 18.0,
      elevation: 0,
    );

    var appBar = new ComMomBar(
      title: widget.pages[currentIndex].title,
      showShadow: false,
      rightDMActions: <Widget>[
        new InkWell(
          child: new Container(
            width: 60.0,
            child: new Image.asset('assets/images/search_black.webp'),
          ),
          onTap: () => routeFadePush(new SearchPage()), // 搜索页
        ),
        new WPopupMenu(
          menuWidth: MediaQuery.of(context).size.width / 2.5,
          alignment: Alignment.center,
          onValueChanged: (String value) {
            if (!strNoEmpty(value)) return;
            actionsHandle(value);
          },
          actions: actions,
          child: new Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: new Image.asset('assets/images/add_addressicon.png',
                color: Colors.black, width: 22.0, fit: BoxFit.fitWidth),
          ),
        )
      ],
    );

    return new Scaffold(
      bottomNavigationBar: new Theme(
        data: new ThemeData(
          canvasColor: Colors.grey[50],
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: new Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: lineColor, width: 0.2))),
          child: bottomNavigationBar,
        ),
      ),
      appBar:
      widget.pages[currentIndex].title != S.of(context).me ? appBar : null,
      body: new ScrollConfiguration(
        behavior: MyBehavior(),
        child: new PageView.builder(
          itemBuilder: (BuildContext context, int index) =>
          widget.pages[index].page,
          controller: pageController,
          itemCount: pages.length,
          physics: Platform.isAndroid
              ? new ClampingScrollPhysics()
              : new NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() => currentIndex = index);
          },
        ),
      ),
    );
  }
}

class TabBarModel {
  const TabBarModel({this.title, this.page, this.icon, this.selectIcon});

  final String title;
  final Widget icon;
  final Widget selectIcon;
  final Widget page;
}
