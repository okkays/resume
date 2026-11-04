import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gruvbox_color_scheme/gruvbox_color_scheme.dart';

const double spacing = 20;

final onDarkColor = GruvboxColorScheme.light.onPrimary;
final onLightColor = GruvboxColorScheme.dark.onPrimary;

MarkdownStyleSheet markdownBodyAs(
  BuildContext context,
  TextStyle Function(TextTheme textTheme) getStyle,
) => .fromTheme(
  Theme.of(context),
).copyWith(p: getStyle(Theme.of(context).textTheme));

extension StrokeColor on Color {
  Color get strokeColor =>
      computeLuminance() > 0.4 ? onLightColor : onDarkColor;
}

const verticalDivider = VerticalDivider(
  width: 20,
  thickness: 1,
  indent: 0,
  endIndent: 0,
  color: Colors.grey,
);

