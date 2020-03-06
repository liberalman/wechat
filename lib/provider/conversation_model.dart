import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../im/model/chat_data.dart';

class ConversationModel extends ChangeNotifier {
  // 会话映射表，是矩阵结构，每个键值对的key都是聊天对方的用户id，
  // 值是包裹了与其聊天的所有数据的列表。当然如果数据量大我们并非将所有聊天数据都加载进来，
  // 而是更多的数据放入sqlite，值加载当前最新一一页，如果用户有刷旧数据的动作，再往前翻页。
  final Map<String, List<ChatData>> _conversations = Map();

  // 添加一条聊天信息
  void add(ChatData chatData) {
    // 如果同该用户的聊天列表已经存在，则直接插入聊天列表中
    if (_conversations.containsKey(chatData.userId)) {
      _conversations[chatData.userId].add(chatData);
    } else { // 否则先新增聊天列表，再添加聊天内容
      List<ChatData> list = new List();
      list.add(chatData);
      _conversations[chatData.userId] = list;
    }
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
    // put在放入数据时，如果放入数据的key已经存在与Map中，最后放入的数据会覆盖之前存在的数据，
    //而putIfAbsent在放入数据时，如果存在重复的key，那么putIfAbsent不会放入值。
  }

  // 删除一条聊天信息
  void delete(ChatData chatData) {
    if (_conversations.containsKey(chatData.userId)) {
      _conversations[chatData.userId].removeWhere((value){
        if (value.time == chatData.time)
          return true;
        else
          return false;
      });
    }
  }

  // 查询聊天列表
  List<ChatData> query(String id, int startTime, int num) {}

  // 删除与一个用户的所有聊天内容
  void deleteConversation(id) {
    _conversations.remove(id);
  }
}