import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume/flutter_constants.dart';
import 'package:resume/constants.dart';

class DateDisplay extends StatelessWidget {
  final DateTime? startDate;
  final String? prefix;
  final DateTime? endDate;
  final Color color;

  const DateDisplay({
    this.startDate,
    this.prefix,
    this.endDate,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double padding = 3;

    final HSLColor hsl = HSLColor.fromColor(color);
    final darkerColor = hsl.withLightness(hsl.lightness / 2).toColor();

    return DefaultTextStyle(
      style: textThemes(
        context,
      )['labelMediumMono']!.copyWith(color: color.strokeColor),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: .circular(5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: .circular(5),
              ),
              child: Padding(
                padding: .all(padding),
                child: Wrap(
                  children: [
                    Visibility(
                      visible: startDate != null,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: .only(right: spacing / 2),
                            child: CustomPaint(
                              painter: _ToPainter(
                                padding: padding,
                                arrowWidth: spacing / 3,
                                color: darkerColor,
                              ),
                              child: Padding(
                                padding: .only(right: spacing / 4),
                                child: _DatePart(date: startDate, color: color),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _DatePart(date: endDate, color: color),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: prefix != null,
            child: Text(prefix ?? '', style: textThemes(context)['labelSmall']),
          ),
        ],
      ),
    );
  }
}

class _DatePart extends StatelessWidget {
  final DateTime? date;
  final Color color;

  const _DatePart({this.date, required this.color});

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      return Column(children: [Text('present')]);
    } else {
      final month = DateFormat('MM').format(date!);
      final year = DateFormat('y').format(date!);

      return Column(
        children: [
          IntrinsicHeight(
            child: Wrap(
              children: [
                Text([year, month].map((p) => p.toLowerCase()).join('-')),
              ],
            ),
          ),
        ],
      );
    }
  }
}

class _ToPainter extends CustomPainter {
  final Color color;
  final double arrowWidth;
  final double padding;
  _ToPainter({
    required this.arrowWidth,
    required this.padding,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint();
    stroke.color = color;
    stroke.style = .fill;
    stroke.strokeWidth = 1;
    stroke.strokeJoin = .round;
    stroke.strokeCap = .round;

    final path = Path();
    path.moveTo(-padding - 1, -padding - 1);
    path.lineTo(size.width, -padding - 1);
    path.lineTo(size.width + arrowWidth, size.height / 2);
    path.lineTo(size.width, size.height + padding + 1);
    path.lineTo(-padding - 1, size.height + padding + 1);

    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
