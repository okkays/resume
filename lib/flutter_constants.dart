import 'package:flutter/material.dart';
import 'package:gruvbox_color_scheme/gruvbox_color_scheme.dart';

const double spacing = 20;
const double maxWidth = 850;

final onDarkColor = GruvboxColorScheme.light.onPrimary;
final onLightColor = GruvboxColorScheme.dark.onPrimary;

extension StrokeColor on Color {
  Color get strokeColor =>
      computeLuminance() > 0.4 ? onLightColor : onDarkColor;
}

final verticalDivider = VerticalDivider(
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

Map<String, TextStyle> textThemes(BuildContext context) => {
  'bodyMedium': TextTheme.of(context).bodyMedium!,
  'labelSmall': TextTheme.of(context).labelSmall!,
  'labelMedium': TextTheme.of(context).labelMedium!,
  'labelMediumMono': TextTheme.of(context).labelMedium!
      .copyWith(fontFamily: 'Hack'),
  'titleLarge': TextTheme.of(context).titleLarge!,
  'headlineSmall': TextTheme.of(context).headlineSmall!,
  'headlineMedium': TextTheme.of(context).headlineMedium!,
};
Brightness ofBrightness(BuildContext context) => Theme.of(context).brightness;
ColorScheme ofColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;
double ofWidth(BuildContext context) => MediaQuery.of(context).size.width;
Color ofBackgroundColor(BuildContext context) =>
    Theme.of(context).scaffoldBackgroundColor;
