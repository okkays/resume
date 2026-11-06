import 'package:flutter/material.dart' as mat;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:resume/content.dart';
import 'package:resume/widgets/resume_pdf/icon_box.dart';
import 'package:resume/widgets/resume_pdf/link.dart';
import 'package:resume/pdf_constants.dart';
import 'package:resume/widgets/resume_pdf/tag.dart';
import 'package:collection/collection.dart';
import 'package:resume/widgets/resume_pdf/experience_view.dart';

class Resume extends StatelessWidget {
  final mat.ColorScheme colorScheme;
  final PdfColor backgroundColor;
  final Uint8List image;
  Resume({
    required this.image,
    required this.colorScheme,
    required this.backgroundColor,
  });

  final int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    final avatar = ClipRRect(
      horizontalRadius: 20,
      verticalRadius: 20,
      child: Image(MemoryImage(image), height: 125),
    );

    return DecoratedBox(
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: EdgeInsets.all(0.25 * PdfPageFormat.inch),
        child: Column(
          mainAxisSize: .min,
          children: spaceChildren(
            direction: .vertical,
            spacing: spacing,
            children: [
              Row(
                mainAxisSize: .min,
                children: spaceChildren(
                  direction: .horizontal,
                  spacing: spacing / 2,
                  children: [
                    avatar,
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: spacing / 2),
                        child: Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .start,
                          children: spaceChildren(
                            direction: .vertical,
                            spacing: spacing / 2,
                            children: [
                              Text(
                                C.name,
                                style: textThemes(
                                  backgroundColor.strokeColor,
                                )['headlineMedium'],
                              ),
                              FittedBox(
                                fit: .fitWidth,
                                child: Text(
                                  C.jobTitle,
                                  style: textThemes(
                                    backgroundColor.strokeColor,
                                  )['headlineSmall'],
                                ),
                              ),
                              FittedBox(
                                fit: .fitWidth,
                                child: Row(
                                  children: [
                                    ResumeLink(
                                      label: C.email,
                                      href: 'mailto:${C.email}',
                                      backgroundColor: backgroundColor,
                                    ),
                                    verticalDivider,
                                    ResumeLink(
                                      label: [
                                        C.phone.substring(0, 3),
                                        C.phone.substring(3, 6),
                                        C.phone.substring(6),
                                      ].join('.'),
                                      href: 'tel:${C.phone}',
                                      backgroundColor: backgroundColor,
                                    ),
                                    verticalDivider,
                                    ResumeLink(
                                      label: C.web,
                                      href: C.web,
                                      backgroundColor: backgroundColor,
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                spacing: spacing / 4,
                                runSpacing: spacing / 4,
                                children: [
                                  ...C.headlineTags.map(
                                    (h) => Tag(
                                      h.toLowerCase().replaceAll(' ', '_'),
                                      color: fromColor(colorScheme.secondary),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: .min,
                children: [
                  Expanded(
                    child: IconBox(
                      label: 'About me',
                      color: fromColor(colorScheme.primary),
                      backgroundColor: backgroundColor,
                      icon: Icons.elevator,
                      child: MarkdownBody(
                        backgroundColor: backgroundColor,
                        data: C.elevator.join('\n'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: .min,
                children: [
                  Expanded(
                    child: IconBox(
                      label: 'Skillset',
                      color: fromColor(colorScheme.tertiary),
                      backgroundColor: backgroundColor,
                      icon: Icons.handyman_outlined,
                      child: Column(
                        crossAxisAlignment: .stretch,
                        children: spaceChildren(
                          direction: .vertical,
                          spacing: spacing / 2,
                          children: [
                            Wrap(
                              spacing: spacing / 2,
                              runSpacing: spacing / 2,
                              crossAxisAlignment: .start,
                              children: [
                                ...C.expertiseChips.expandIndexed(
                                  (i, chips) => chips.map(
                                    (c) => Tag(
                                      c.toLowerCase().replaceAll(' ', '_'),
                                      color: [
                                        fromColor(colorScheme.primary),
                                        fromColor(colorScheme.tertiary),
                                      ][i % 2],
                                    ),
                                  ),
                                ),
                                Tag(
                                  'etc',
                                  color: fromColor(colorScheme.secondary),
                                ),
                              ],
                            ),
                            Divider(color: fromColor(colorScheme.tertiary)),
                            MarkdownBody(
                              backgroundColor: backgroundColor,
                              data: C.expertiseHeadline.join('\n'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                // To fit things in the PDF, put college up front here
                mainAxisSize: .min,
                children: [
                  Expanded(
                    child: IconBox(
                      backgroundColor: backgroundColor,
                      color: fromColor(colorScheme.tertiary),
                      label: 'Education',
                      icon: Icons.work_history,
                      child: ExperienceView(
                        C.education.first,
                        color: fromColor(colorScheme.tertiary),
                        backgroundColor: backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
              ...C.experience.map(
                (e) => Row(
                  mainAxisSize: .min,
                  children: [
                    Expanded(
                      child: IconBox(
                        backgroundColor: backgroundColor,
                        color: fromColor(colorScheme.secondary),
                        label: 'Past Experience',
                        icon: Icons.work_history,
                        child: ExperienceView(
                          e,
                          color: fromColor(colorScheme.secondary),
                          backgroundColor: backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...C.education
                  .slice(1)
                  .map(
                    (e) => Row(
                      mainAxisSize: .min,
                      children: [
                        Expanded(
                          child: IconBox(
                            backgroundColor: backgroundColor,
                            color: fromColor(colorScheme.tertiary),
                            label: 'Education',
                            icon: Icons.work_history,
                            child: ExperienceView(
                              e,
                              color: fromColor(colorScheme.tertiary),
                              backgroundColor: backgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
