import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gruvbox_color_scheme/gruvbox_color_scheme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const double spacing = 20;

const double maxWidth = 850;

final onDarkColor = GruvboxColorScheme.light.onPrimary;
final onLightColor = GruvboxColorScheme.dark.onPrimary;

final pdfOnDarkColor = PdfColor.fromInt(
  GruvboxColorScheme.light.onPrimary.toARGB32(),
);
final pdfOnLightColor = PdfColor.fromInt(
  GruvboxColorScheme.dark.onPrimary.toARGB32(),
);

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

extension StrokeColor on Color {
  Color get strokeColor =>
      computeLuminance() > 0.4 ? onLightColor : onDarkColor;
}

extension PdfStrokeColor on PdfColor {
  PdfColor get strokeColor =>
      luminance > 0.4 ? pdfOnLightColor : pdfOnDarkColor;
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

final List<String> images = [
  'images/me.jpg',
  'images/lua.png',
  'images/code.png',
];

Map<String, TextStyle> textThemes(BuildContext context) => {
  'labelMedium': TextTheme.of(context).labelMedium!,
};

Map<String, pw.TextStyle> pdfTextThemes(pw.Context context) => {
  'labelMedium': pw.TextStyle(),
};
