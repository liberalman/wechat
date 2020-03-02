import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/global_model.dart';
import '../provider/login_model.dart';

/*
* Flutter状态管理Provider
*
* 学习Flutter一段时间了，偶然看到大家都说状态管理，多数人都是用redux，对于一个
* Android开发人员来说之前根本没接触过，于是开始了解redux，之后又了解闲鱼推出的
* fish_redux,然后又看到Vadaski发表的一系列关于Flutter状态管理的文章，包括
* Scoped Model, Redux, BLoC,RxDart,provide（想了解的可以移步）,看的是
* 眼花缭乱。对于Redux，能看懂是怎么写的，但真要到应用的层面，感觉还是有些吃力，
* 更不知道怎样维护好它，一时间也不知道用什么什么适合自己。后来又接触到google
* 推荐的Provider，于是学习了下。
* */

class ProviderConfig {
  static ProviderConfig _instance;

  static ProviderConfig getInstance() {
    if (null == _instance) {
      _instance = ProviderConfig._internal();
    }
    return _instance;
  }

  // global 数据变化的消息通知
  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child) {
    return ChangeNotifierProvider<GlobalModel> (
      builder: (context) => GlobalModel(),
      child: child,
    );
  }

  // login page
  ChangeNotifierProvider<LoginModel> getLoginPage(Widget child) {
    return ChangeNotifierProvider<LoginModel>(
      builder: (context) => LoginModel(),
      child: child,
    );
  }

  ProviderConfig._internal();
}