import 'package:event_bus/event_bus.dart';
/// 创建EventBus
EventBus eventBus = EventBus();

/// Event 修改主题色
class ChatEvent {
  String sender;
  String roomId;
  String content;

  ChatEvent({this.sender, this.roomId, this.content});
}


