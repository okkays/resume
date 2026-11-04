import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gruvbox_color_scheme/gruvbox_color_scheme.dart';

const double spacing = 20;

const double maxWidth = 850;

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

Widget columnIfMobileElseStack({
  required MainAxisAlignment alignmentIfColumn,
  required AlignmentGeometry alignmentIfStack,
  required double spacingIfColumn,
  required List<Widget> children,
  required bool isMobile,
}) {
  if (isMobile) {
    return Column(
      spacing: spacingIfColumn,
      mainAxisAlignment: alignmentIfColumn,
      children: children,
    );
  }
  return Stack(alignment: alignmentIfStack, children: children);
}
