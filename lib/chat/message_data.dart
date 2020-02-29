class MessageData {
  String avatar;
  String title;
  String subTitle;
  DateTime time;
  MessageType type;

  MessageData(this.avatar, this.title, this.subTitle, this.time, this.type);
}

enum MessageType { SYSTEM, PUBLIC, CHAT, GROUP }

List<MessageData> messageData = [
  new MessageData(
      'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2468063292,3097171608&fm=26&gp=0.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.CHAT),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Andy',
      'Im fine!',
      new DateTime.now(),
      MessageType.GROUP),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.SYSTEM),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.PUBLIC),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.CHAT),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.CHAT),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.CHAT),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.CHAT),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.CHAT),
  new MessageData(
      'http://www.chachaba.com/news/uploads/180726/4168_180726140635_1.jpg',
      'Jacky',
      'Hello!',
      new DateTime.now(),
      MessageType.CHAT),
];
