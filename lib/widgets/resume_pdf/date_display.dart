import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';
import 'package:resume/pdf_constants.dart';
import 'package:resume/constants.dart';

class DateDisplay extends StatelessWidget {
  final DateTime? startDate;
  final String? prefix;
  final DateTime? endDate;
  final Color color;

  DateDisplay({this.startDate, this.prefix, this.endDate, required this.color});

  @override
  Widget build(BuildContext context) {
    final double padding = 3;

    final hsl = color.toHsl();
    final darkerColor = Color.fromInt(
      hsl.withLightness(hsl.lightness / 2).toInt(),
    );

    return DefaultTextStyle(
      style: textThemes(
        context,
      )['labelMediumMono']!.copyWith(color: color.strokeColor),
      child: Column(
        children: [
          ClipRRect(
            verticalRadius: 5,
            horizontalRadius: 5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Wrap(
                  children: [
                    ...(startDate == null
                        ? []
                        : [
                            Wrap(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: spacing / 2),
                                  child: CustomPaint(
                                    painter: _toPainter(
                                      padding: padding,
                                      arrowWidth: spacing / 3,
                                      color: darkerColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: spacing / 4,
                                      ),
                                      child: _DatePart(
                                        date: startDate,
                                        color: color,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    _DatePart(date: endDate, color: color),
                  ],
                ),
              ),
            ),
          ),
          ...(prefix == null
              ? []
              : [
                  Text(
                    prefix!,
                    style: textThemes(context)['labelSmall']!.copyWith(
                      color: ofBackgroundColor(context).strokeColor,
                    ),
                  ),
                ]),
        ],
      ),
    );
  }
}

class _DatePart extends StatelessWidget {
  final DateTime? date;
  final Color color;

  _DatePart({this.date, required this.color});

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      return Column(children: [Text('present')]);
    } else {
      final month = DateFormat('MM').format(date!);
      final year = DateFormat('y').format(date!);

      return Column(
        children: [
          Wrap(
            children: [
              Text([year, month].map((p) => p.toLowerCase()).join('-')),
            ],
          ),
        ],
      );
    }
  }
}

CustomPainter _toPainter({
  required double arrowWidth,
  required double padding,
  required Color color,
}) {
  return (PdfGraphics canvas, PdfPoint point) {
    final width = point.x;
    final height = point.y;
    print('boop $width $height');

    canvas.setFillColor(color);
    canvas.setLineWidth(1);
    canvas.setLineJoin(.round);
    canvas.setLineCap(.round);

    canvas.moveTo(-padding - 1, -padding - 1);
    canvas.lineTo(width, -padding - 1);
    canvas.lineTo(width + arrowWidth, height / 2);
    canvas.lineTo(width, height + padding + 1);
    canvas.lineTo(-padding - 1, height + padding + 1);
    canvas.lineTo(-padding - 1, -padding - 1);
    canvas.fillPath();
  };
}
