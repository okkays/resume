import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gruvbox_color_scheme/gruvbox_color_scheme.dart';


final lightTheme = ThemeData(
  fontFamily: 'Lato',
  colorScheme: GruvboxColorScheme.light,
);

final darkTheme = ThemeData(
  fontFamily: 'Lato',
  colorScheme: GruvboxColorScheme.dark,
);

MarkdownStyleSheet markdownBodyAs(
  BuildContext context,
  TextStyle Function(TextTheme textTheme) getStyle,
) => .fromTheme(
  Theme.of(context),
).copyWith(p: getStyle(Theme.of(context).textTheme));

final List<String> images = [
  'images/me.jpg',
  'images/lua.png',
  'images/code.png',
];
