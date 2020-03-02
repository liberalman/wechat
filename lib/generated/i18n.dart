import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// 语言国际化
class S implements WidgetsLocalizations {
  const S();

  static const GeneratedLocalizationsDelegate delegate =
      const GeneratedLocalizationsDelegate();

  static S of(BuildContext context) =>
      Localizations.of<S>(context, WidgetsLocalizations);

  // 获取文字和变量的对照表
  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get register => "Register";
  String get login => "Login";
  String get language => "Language";
  String get multiLanguage => "Multi-Language";
}

class en extends S {
  const en();
}

class zh_CN extends S {
  const zh_CN();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();

  // 支持的语言列表
  List<Locale> get supportedLocales {
    return const <Locale>[
      const Locale("en", ""), // 英文
      const Locale("zh", "CN"), // 中文
    ];
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    final String lang = getLang(locale);
    switch (lang) {
      case "en":
        return new SynchronousFuture<WidgetsLocalizations>(const en());
      case "zh_CN":
        return new SynchronousFuture<WidgetsLocalizations>(const zh_CN());
      default:
        return new SynchronousFuture<WidgetsLocalizations>(const S());
    }
  }

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale); // 是否支持此语言

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false; // 不需重载
}

String getLang(Locale l) => l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();