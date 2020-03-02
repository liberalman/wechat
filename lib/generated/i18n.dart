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
  String get mobileNumberLogin => "Mobile number login";
  String get selectCountry => "Select country or region";
  String get phoneCity => "Country";
  String get nextStep => "Next step";
  String get notOpen => "Not yet open";
  String get userLoginTip => "WeChat number / QQ number / email";
  String get phoneNumber => "Phone";
  String get phoneNumberHint => "Please fill in your phone number";

  // country
  String get australia => "Australia";
  String get canada => "Canada";
  String get chinaMainland => "China Mainland";
  String get contacts => "Contacts";
  String get discover => "Discover";
  String get emergencyFreeze => "freeze";
  String get retrievePW => "Retrieve";
  String get weChatSecurityCenter => "Security";
  String get exampleName => "For example: Chen Chen";
  String get hongKong => "Hong Kong";
  String get languageTitle => "Change Language";
  String get macao => "Macao";
  String get singapore => "Singapore";
  String get taiwan => "Taiwan";
  String get uS => "United States";

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