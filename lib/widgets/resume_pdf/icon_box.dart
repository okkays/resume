import 'package:pdf/widgets.dart';
import 'package:resume/pdf_constants.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final String? label;
  final Color? color;
  final Color backgroundColor;

  IconBox({
    this.label,
    required this.icon,
    required this.child,
    this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemes(backgroundColor.strokeColor)['bodyMedium']!;
    final iconSize = textTheme.fontSize! * 2;
    final color = this.color ?? textTheme.color!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        overflow: .visible,
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: -(iconSize / 2),
            child: DecoratedBox(
              decoration: BoxDecoration(color: backgroundColor),
              child: Icon(color: color, size: iconSize, icon),
            ),
          ),
          ...(label == null)
              ? []
              : [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -(iconSize / 3),
                    child: Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: backgroundColor),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: spacing / 4,
                            right: spacing / 4,
                          ),
                          child: Text(
                            label ?? '',
                            style: TextStyle(color: color),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
          Padding(padding: EdgeInsets.all(spacing), child: child),
        ],
      ),
    );
  }
}
