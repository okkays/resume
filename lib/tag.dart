import 'package:flutter/material.dart';
import 'package:resume/constants.dart';

class Tag extends StatelessWidget {
  final String content;
  final Color color;
  const Tag(this.content, {required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final strokeColor = color.computeLuminance() > 0.4
        ? onLightColor
        : onDarkColor;

    return DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: .circular(5)),
      child: Padding(
        padding: .all(3),
        child: Text(
          content,
          softWrap: true,
          style: TextTheme.of(context).labelMedium!
              .copyWith(fontFamily: 'Hack', color: strokeColor),
        ),
      ),
    );
  }
}
