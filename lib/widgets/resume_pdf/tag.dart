import 'package:pdf/widgets.dart';
import 'package:resume/pdf_constants.dart';

class Tag extends StatelessWidget {
  final String content;
  final Color color;
  Tag(this.content, {required this.color});

  @override
  Widget build(Context context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(3),
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
