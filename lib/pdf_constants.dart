import 'package:collection/collection.dart';
import 'package:flutter/material.dart' as mat;
import 'package:gruvbox_color_scheme/gruvbox_color_scheme.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:resume/constants.dart';

const double spacing = 0.2 * PdfPageFormat.inch;
const double maxWidth = 8.5 * PdfPageFormat.inch;

class Icons {
  static final elevator = IconData(0xf1a0);
  static final handyman_outlined = IconData(0xf10b);
  static final work_history = IconData(0xe8f9);
}

typedef Color = PdfColor;
typedef BuildContext = Context;

class Colors {
  static final amber = fromColor(mat.Colors.amber);
  static final indigo = fromColor(mat.Colors.indigo);
}

PdfColor fromColor(mat.Color color) {
  return PdfColor.fromInt(color.toARGB32());
}

final onDarkColor = fromColor(GruvboxColorScheme.light.onPrimary);
final onLightColor = fromColor(GruvboxColorScheme.dark.onPrimary);

extension StrokeColor on PdfColor {
  PdfColor get strokeColor => luminance > 0.4 ? onLightColor : onDarkColor;
}

final verticalDivider = SizedBox(
  height: scaleFontSize(20),
  child: VerticalDivider(
    width: 20,
    thickness: 1,
    indent: 0,
    endIndent: 0,
    color: fromColor(mat.Colors.grey),
  ),
);

final Map<String, Font> fonts = {
  // These are loaded in main.dart asynchronously
  // It's a bit of a hack, yes, but it prevents async calls all over everything else.
};

/// Add spacing between children of columns and rows.
/// (PDF library doesn't support the `spacing` param that flutter does)
List<Widget> spaceChildren({
  required Axis direction,
  required double spacing,
  required List<Widget> children,
}) {
  if (children.length <= 1) return [];

  return [
    ...children.slice(0, children.length - 1).map((cell) {
      if (cell.runtimeType == Expanded) {
        final child = (cell as Expanded).child;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: direction == .horizontal ? spacing : 0,
              bottom: direction == .vertical ? spacing : 0,
            ),
            child: child,
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.only(
          right: direction == .horizontal ? spacing : 0,
          bottom: direction == .vertical ? spacing : 0,
        ),
        child: cell,
      );
    }),
    children.last,
  ];
}

double scaleFontSize(double value) {
  return 0.75 * value;
}

Map<String, TextStyle> textThemes(BuildContext? context) {
  final style = TextStyle(
    font: fonts['base'],
    fontNormal: fonts['base'],
    fontBold: fonts['bold'],
    fontItalic: fonts['italic'],
    fontBoldItalic: fonts['boldItalic'],
    height: scaleFontSize(20),
    fontSize: scaleFontSize(14),
    letterSpacing: scaleFontSize(0.25),
  );

  return {
    'bodyMedium': style,
    'labelSmall': style.copyWith(
      fontWeight: .bold,
      height: scaleFontSize(16),
      fontSize: scaleFontSize(11),
      letterSpacing: scaleFontSize(0.5),
    ),
    'labelMedium': style.copyWith(
      fontWeight: .bold,
      height: scaleFontSize(16),
      fontSize: scaleFontSize(12),
      letterSpacing: scaleFontSize(0.5),
    ),
    'labelMediumMono': style.copyWith(
      font: fonts['mono'],
      fontNormal: fonts['mono'],
      fontBold: fonts['mono'],
      fontItalic: fonts['mono'],
      fontBoldItalic: fonts['mono'],
      height: scaleFontSize(16),
      fontSize: scaleFontSize(12),
      letterSpacing: scaleFontSize(0.5),
    ),
    'titleLarge': style.copyWith(
      fontWeight: .normal,
      height: scaleFontSize(28),
      fontSize: scaleFontSize(22),
      letterSpacing: scaleFontSize(0.0),
    ),
    'headlineSmall': style.copyWith(
      fontWeight: .normal,
      height: scaleFontSize(32),
      fontSize: scaleFontSize(24),
      letterSpacing: scaleFontSize(0.0),
    ),
    'headlineMedium': style.copyWith(
      fontWeight: .normal,
      height: scaleFontSize(36),
      fontSize: scaleFontSize(28),
      letterSpacing: scaleFontSize(0.0),
    ),
  };
}

mat.Brightness ofBrightness(BuildContext context) => mat.Brightness.light;
mat.ColorScheme ofColorScheme(BuildContext context) => lightTheme.colorScheme;
double ofWidth(BuildContext context) => context.page.pageFormat.width;
PdfColor ofBackgroundColor(BuildContext context) =>
    fromColor(lightTheme.scaffoldBackgroundColor);

class MarkdownBody extends StatelessWidget {
  final String data;
  MarkdownBody({required this.data});

  @override
  Widget build(Context context) {
    final bodyStyle = textThemes(context)['bodyMedium']!;
    final List<Widget> processed = data.split('\n').map((line) {
      if (line.startsWith(RegExp('^- '))) {
        return Bullet(
          text: line.substring(2),
          style: bodyStyle,
          bulletSize: 1.5 * PdfPageFormat.mm,
          bulletColor: ofBackgroundColor(context).strokeColor,
        );
      }
      return Padding(
        padding: EdgeInsets.only(bottom: spacing / 4),
        child: Text(line, style: bodyStyle),
      );
    }).toList();
    return Column(children: processed);
  }
}
