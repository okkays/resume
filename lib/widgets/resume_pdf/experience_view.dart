import 'package:resume/content.dart';
import 'package:resume/widgets/resume_pdf/date_display.dart';
import 'package:resume/pdf_constants.dart';
import 'package:resume/constants.dart';
import 'package:pdf/widgets.dart';
import 'package:resume/widgets/resume_pdf/tag.dart';

class ExperienceView extends StatelessWidget {
  final Experience E;
  final Color color;
  final Color backgroundColor;
  ExperienceView(this.E, {required this.color, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final companyAndTitle = Center(
      child: Column(
        children: [
          FittedBox(
            fit: .fitWidth,
            child: Text(
              E.title,
              style: textThemes(backgroundColor.strokeColor)['titleLarge'],
            ),
          ),
          ...(E.subtitle == null
              ? []
              : [
                  FittedBox(
                    fit: .fitWidth,
                    child: Text(
                      E.subtitle ?? '',
                      style: TextStyle(color: backgroundColor.strokeColor),
                    ),
                  ),
                ]),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: .start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: maxWidth / 5, right: maxWidth / 5),
              child: companyAndTitle,
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                DateDisplay(
                  backgroundColor: backgroundColor,
                  color: color,
                  prefix: E.datePrefix,
                  startDate: E.startDate,
                  endDate: E.endDate,
                ),
                Tag(E.location, color: color),
              ],
            ),
          ],
        ),
        ...(E.detail.isEmpty ? [] : [Divider(color: color)]),
        ...(E.detail.isEmpty
            ? []
            : [
                MarkdownBody(
                  backgroundColor: backgroundColor,
                  data: E.detail.join('\n'),
                ),
              ]),
      ],
    );
  }
}
