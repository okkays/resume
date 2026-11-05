import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:resume/constants.dart';

class PdfTag extends StatelessWidget {
  final String content;
  final PdfColor color;
  PdfTag(this.content, {required this.color});

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
          style: pdfTextThemes(context)['labelMedium']!.copyWith(
            // fontFamily: 'Hack',
            color: color.strokeColor,
          ),
        ),
      ),
    );
  }
}
