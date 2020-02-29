import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './contacts_vo.dart';

class ContactSiderList extends StatefulWidget {
  final List<ContactVO> items;
  final IndexedWidgetBuilder headerBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder sectionBuilder;

  ContactSiderList(
      {Key key,
      @required this.items,
      this.headerBuilder,
      @required this.itemBuilder,
      @required this.sectionBuilder})
      : super(key: key);

  @override
  ContactState createState() => new ContactState();
}

class ContactState extends State<ContactSiderList> implements SectionIndexer {
  Color _pressColor = Colors.transparent; // 背景颜色默认透明
  final ScrollController _scrollController = new ScrollController();

  bool _onNotification(ScrollNotification notification) {
    return true;
  }

  _isShowHeaderView(index) {
    if (index == 0 && widget.headerBuilder != null) {
      // 没有数据的时候，给做个占位符
      return Offstage(
        offstage: false,
        child: widget.headerBuilder(context, index),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 列表加载更多
          NotificationListener(
            onNotification: _onNotification,
            child: ListView.builder(
                controller: _scrollController,
                // 以下是为了让list里面内容不一致时候，list依然可以滑动
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        _isShowHeaderView(index),
                        Offstage(
                          offstage: _shouldShowHeader(index),
                          child: widget.sectionBuilder(context, index),
                        ),
                        Column(
                          children: <Widget>[
                            widget.itemBuilder(context, index)
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
          // 排序
          Positioned(
            right: 0.0,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: 32.0,
              color: _pressColor,
              child: GestureDetector(
                // 按下
                onTapDown: (TapDownDetails t) {
                  setState(() {
                    _pressColor = Colors.grey;
                  });
                },
                // 弹起
                onTapUp: (TapUpDetails t) {
                  setState(() {
                    _pressColor = Colors.transparent;
                  });
                },
                // 开始垂直滑动
                onVerticalDragStart: (DragStartDetails t) {
                  setState(() {
                    _pressColor = Colors.grey;
                  });
                },
                // 结束垂直滑动
                onVerticalDragEnd: (DragEndDetails t) {
                  setState(() {
                    _pressColor = Colors.transparent;
                  });
                },
                // 手指垂直滑动时
                onVerticalDragUpdate: (DragUpdateDetails t) {
                  setState(() {
                    _pressColor = Colors.grey;
                  });
                },
                child: ListView.builder(
                  controller: ScrollController(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      height: 17.0,
                      child: Text(siderBarKey[index]),
                    );
                  },
                  itemCount: siderBarKey.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  listScrollToPosition(int index) {
    for (var i = 0; i < widget.items.length; i++) {
      if (siderBarKey[index] == "*" || siderBarKey[index] == "!") {
        _scrollController.jumpTo(0.0);
        setState(() {

        });
        return -1;
      } else if (widget.items[i].seationKey == siderBarKey[index]) {
        return i;
      }
    }
    return -1;
  }

  bool _shouldShowHeader(int position) {
    if (position < 0) {
      return false;
    }
    if (position == 0) {
      return false;
    }
    if (position != 0 &&
        widget.items[position].seationKey !=
            widget.items[position - 1].seationKey) {
      return false;
    }
    return true;
  }
}

abstract class SectionIndexer {
  listScrollToPosition(int index); // 返回最上面
}

const siderBarKey = <String>["*", "!", "A", "B", "C", "D", "E", "F",
  "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
  "U", "V", "W", "X", "Y", "Z"];
