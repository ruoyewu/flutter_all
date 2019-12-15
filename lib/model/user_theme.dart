import 'package:all/model/user_color.dart';
import 'package:flutter/material.dart';

class UserTheme {
  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: UserColor.COLOR_HUNTER_GREEN,
        canvasColor: UserColor.COLOR_NERO,
        accentColor: UserColor.COLOR_HOKI,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: UserColor.COLOR_MONSOON,
            splashColor: UserColor.COLOR_MINE_SHAFT),
        iconTheme: IconThemeData(color: UserColor.COLOR_MERCURY),
        textTheme: UserTextTheme.dark(),
      );

  static ThemeData light() => ThemeData(
      primaryColor: UserColor.COLOR_ALABASTER,
      primarySwatch: Colors.blueGrey,
      canvasColor: UserColor.COLOR_ALABASTER,
      textTheme: UserTextTheme.light(),
      iconTheme: IconThemeData(color: UserColor.COLOR_DARK_GRAY));
}

class UserTextTheme extends TextTheme {
  UserTextTheme(
      {this.normal,
      this.h1,
      this.h2,
      this.h3,
      this.h4,
      this.li,
      this.quote,
      this.bold,
      this.subTitle,
      this.em,
      this.link,
      this.pre,
      this.aside,
      this.little,
      this.itemTag,
      this.itemTitle,
      this.itemAuthor,
      this.itemForward,
      this.itemTime});

  factory UserTextTheme.auto(BuildContext context) {
    if (_isDark(context)) {
      return UserTextTheme.dark();
    } else {
      return UserTextTheme.light();
    }
  }

  factory UserTextTheme.dark() => UserTextTheme(
      normal: const TextStyle(
          fontSize: 16, color: UserColor.COLOR_LIGHT_GRAY, height: 1.7),
      h1: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: UserColor.COLOR_ALABASTER,
          height: 1.8),
      h2: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: UserColor.COLOR_ALABASTER,
          height: 1.8),
      h3: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: UserColor.COLOR_ALABASTER,
          height: 1.7),
      h4: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: UserColor.COLOR_ALABASTER),
      bold: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: UserColor.COLOR_LIGHT_GRAY),
      em: const TextStyle(
        fontSize: 16,
        height: 1.7,
        color: UserColor.COLOR_PINK_LACE,
      ),
      link: const TextStyle(
          fontSize: 15,
          color: UserColor.COLOR_MOUNTAIN_MIST,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: UserColor.COLOR_MONSOON),
      pre: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
      aside: const TextStyle(color: UserColor.COLOR_MERCURY, fontSize: 15),
      little: const TextStyle(fontSize: 12, color: UserColor.COLOR_MONSOON),
      itemTitle: const TextStyle(
          fontSize: 18, color: UserColor.COLOR_MERCURY, height: 1.7),
      itemAuthor: const TextStyle(
        fontSize: 15,
        color: UserColor.COLOR_MOUNTAIN_MIST,
      ),
      itemForward:
          const TextStyle(fontSize: 16, color: UserColor.COLOR_SILVER_CHALICE),
      itemTime:
          const TextStyle(fontSize: 12, color: UserColor.COLOR_MOUNTAIN_MIST),
      itemTag: const TextStyle(fontSize: 15, color: UserColor.COLOR_HOKI));

  factory UserTextTheme.light() => UserTextTheme(
      normal: const TextStyle(
          fontSize: 16, color: UserColor.COLOR_DARK_GRAY, height: 1.7),
      h1: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: UserColor.COLOR_ONYX,
          height: 1.8),
      h2: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: UserColor.COLOR_ONYX,
          height: 1.8),
      h3: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: UserColor.COLOR_ONYX,
          height: 1.7),
      h4: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: UserColor.COLOR_ONYX),
      bold: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: UserColor.COLOR_MOUNTAIN_MIST),
      em: const TextStyle(
        fontSize: 16,
        height: 1.7,
        color: UserColor.COLOR_CLOUD_BURST,
      ),
      link: const TextStyle(
          fontSize: 15,
          color: UserColor.COLOR_MOUNTAIN_MIST,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: UserColor.COLOR_MOUNTAIN_MIST),
      pre: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
      aside: const TextStyle(color: UserColor.COLOR_MONSOON, fontSize: 15),
      little:
          const TextStyle(fontSize: 12, color: UserColor.COLOR_MOUNTAIN_MIST),
      itemTitle: const TextStyle(
          fontSize: 17, color: UserColor.COLOR_NERO, height: 1.7),
      itemAuthor: const TextStyle(
        fontSize: 14,
        color: UserColor.COLOR_MONSOON,
      ),
      itemForward:
          const TextStyle(fontSize: 15, color: UserColor.COLOR_MINE_SHAFT),
      itemTime:
          const TextStyle(fontSize: 13, color: UserColor.COLOR_MOUNTAIN_MIST),
      itemTag: const TextStyle(fontSize: 14, color: UserColor.COLOR_HOKI));

  final TextStyle normal;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle li;
  final TextStyle quote;
  final TextStyle bold;
  final TextStyle subTitle;
  final TextStyle em;
  final TextStyle link;
  final TextStyle pre;
  final TextStyle aside;
  final TextStyle little;
  final TextStyle itemTag;
  final TextStyle itemTitle;
  final TextStyle itemAuthor;
  final TextStyle itemForward;
  final TextStyle itemTime;

  static bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
