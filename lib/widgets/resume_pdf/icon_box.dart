import 'package:flutter/material.dart';
import 'package:resume/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class IconBox extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final String? label;
  final Color? color;
  final Color? backgroundColor;

  const IconBox({
    this.label,
    required this.icon,
    required this.child,
    this.color,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context).bodyMedium!;
    final iconSize = textTheme.fontSize! * 2;
    final color = this.color ?? textTheme.color!;
    final backgroundColor =
        this.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    return CustomPaint(
      painter: _IconBoxPainter(
        eraseWidth: iconSize + 5,
        color: color,
        backgroundColor: backgroundColor,
      ),
      child: Stack(
        clipBehavior: .none,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: -(iconSize / 2),
            child: Icon(color: color, size: iconSize, icon),
          ),
          Visibility(
            visible: label != null,
            child: Positioned(
              left: 0,
              right: 0,
              top: -(iconSize / 3),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: backgroundColor),
                  child: Padding(
                    padding: .only(left: spacing / 4, right: spacing / 4),
                    child: Text(label ?? '', style: TextStyle(color: color)),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: .all(spacing), child: child),
        ],
      ),
    );
  }
}

class _IconBoxPainter extends CustomPainter {
  final Color color;
  final Color backgroundColor;
  final double eraseWidth;
  _IconBoxPainter({
    required this.color,
    required this.backgroundColor,
    required this.eraseWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint();
    border.color = color;
    border.style = .stroke;
    border.strokeWidth = 2;
    border.strokeJoin = .round;
    border.strokeCap = .round;

    final erase = Paint();
    erase.color = backgroundColor;
    erase.style = .fill;
    erase.strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
        Radius.circular(10),
      ),
      border,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(0, size.height / 2),
        width: eraseWidth,
        height: eraseWidth,
      ),
      erase,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
