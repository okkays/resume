import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:resume/content.dart';
import 'package:resume/widgets/resume/date_display.dart';
import 'package:resume/flutter_constants.dart';
import 'package:resume/constants.dart';
import 'package:resume/widgets/resume/tag.dart';

class ExperienceView extends StatelessWidget {
  final Experience E;
  final Color color;
  final bool isMobile;
  const ExperienceView(
    this.E, {
    required this.color,
    required this.isMobile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final companyAndTitle = Center(
      child: Column(
        children: [
          FittedBox(
            fit: .fitWidth,
            child: Text(E.title, style: textThemes(context)['titleLarge']),
          ),
          Visibility(
            visible: E.subtitle != null,
            child: FittedBox(fit: .fitWidth, child: Text(E.subtitle ?? '')),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: .start,
      children: [
        columnIfMobileElseStack(
          isMobile: isMobile,
          alignmentIfColumn: .center,
          alignmentIfStack: .center,
          spacingIfColumn: spacing / 4,
          children: [
            isMobile
                ? companyAndTitle
                : Padding(
                    padding: .only(left: maxWidth / 5, right: maxWidth / 5),
                    child: companyAndTitle,
                  ),
            OverflowBar(
              alignment: .spaceBetween,
              overflowSpacing: spacing / 4,
              children: [
                DateDisplay(
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
        Visibility(
          visible: E.detail.isNotEmpty,
          child: Divider(color: color),
        ),
        Visibility(
          visible: E.detail.isNotEmpty,
          child: MarkdownBody(data: E.detail.join('\n')),
        ),
      ],
    );
  }
}
