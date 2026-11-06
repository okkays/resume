import 'package:flutter/material.dart';
import 'package:resume/flutter_constants.dart';

class Tag extends StatelessWidget {
  final String content;
  final Color color;
  const Tag(this.content, {required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: .circular(5)),
      child: Padding(
        padding: .all(3),
        child: Text(
          content,
          softWrap: true,
          style: textThemes(
            context,
          )['labelMediumMono']!.copyWith(color: color.strokeColor),
        ),
      ),
    );
  }
}
