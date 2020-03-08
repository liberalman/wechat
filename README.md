# wechat
使用 Flutter 框架开发的高仿微信项目

flutter学习网站 https://book.flutterchina.club/chapter7/provider.html

# 登录
pages/login/login_begin_page.dart 这个页面显示微信小人背景图片，放入 登录、注册、语言选择 按钮
    |_ pages/login/login_page.dart 登录页面。填写手机号，点击登录。
      |_ im/login_handle.dart 和远程服务器交互以验证登录。

im/info_handle.dart 获取某个用户的信息，数据初始化。
im/conversation_handle.dart 消息列表数据初始化在这里赋值。
im/friends_handle.dart 好友列表，数据初始化。
im/message_handle.dart 对话消息，数据初始化。
im/model/chat_list.dart 获取对话列表。
im/model/conversation_handle.dart 获取对话列表，数据初始化。
im/model/chat_data.dart 聊天消息数据


# 聊天
pages/home/home_page.dart 首页,root
    |_ ui/chat/my_conversation_view.dart 首页聊天列表


pages/chat/chat_page.dart 聊天窗口外框
    |_ ui/chat/chat_details_body.dart 聊天窗口内框，显示聊天内容
    |_ ui/chat/chat_details_row.dart  聊天窗口底部栏，包括语音、文字输入框、more按钮
        |_ ui/item/chat_mor_icon.dart 文字输入框
          |_ im/send_handle.dart 发送消息，这个方法是调用mqtt的publish方式发到远程服务器的

ui/message_view/text_message.dart 文本类型的消息样式