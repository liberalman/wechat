import './store.dart';
export './store.dart';
export './notice.dart';

class WeChatActions {
  static String msg() => 'msg';

  static String voiceImg() => 'voiceImg';
}

class Data {
  static String msg() => Store(WeChatActions.msg()).value = '';

  static String voiceImg() => Store(WeChatActions.voiceImg()).value = '';
}
