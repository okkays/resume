import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:resume/content.dart';
import 'package:resume/widgets/icon_box.dart';
import 'package:resume/widgets/link.dart';
import 'package:resume/constants.dart';
import 'package:resume/widgets/tag.dart';
import 'package:collection/collection.dart';
import 'package:resume/widgets/experience_view.dart';

class Resume extends StatefulWidget {
  final ValueChanged<Brightness> onBrightnessChanged;

  const Resume({super.key, required this.onBrightnessChanged});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    for (var image in images) {
      precacheImage(AssetImage(image), context);
    }

    final query = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile = query.size.width < 500;
    final isDesktop = !isMobile;

    final avatar = ClipRRect(
      borderRadius: .circular(20),
      child: InkWell(
        borderRadius: .circular(20),
        onTap: () {
          setState(() {
            selectedImage = (selectedImage + 1) % images.length;
          });
        },
        child: Image.asset(
          images[selectedImage],
          height: isMobile ? query.size.width - query.size.width / 6 : 100,
        ),
      ),
    );

    return Column(
      spacing: spacing,
      children: [
        Visibility(visible: isMobile, child: avatar),
        IntrinsicHeight(
          child: Row(
            spacing: spacing / 2,
            crossAxisAlignment: isMobile ? .start : .stretch,
            children: [
              Visibility(visible: isDesktop, child: avatar),
              Expanded(
                child: Padding(
                  padding: .only(right: spacing / 2),
                  child: Column(
                    spacing: spacing / 2,
                    mainAxisAlignment: .center,
                    crossAxisAlignment: isDesktop ? .start : .stretch,
                    children: [
                      Text(C.name, style: TextTheme.of(context).headlineMedium),
                      FittedBox(
                        fit: .fitWidth,
                        child: Text(
                          C.jobTitle,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                      ),
                      FittedBox(
                        fit: .fitWidth,
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              ResumeLink(
                                label: C.email,
                                href: 'mailto:${C.email}',
                              ),
                              verticalDivider,
                              ResumeLink(
                                label: [
                                  C.phone.substring(0, 3),
                                  C.phone.substring(3, 6),
                                  C.phone.substring(6),
                                ].join('.'),
                                href: 'tel:${C.phone}',
                              ),
                              verticalDivider,
                              ResumeLink(label: C.web, href: C.web),
                            ],
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: spacing / 2,
                        runSpacing: spacing / 2,
                        children: [
                          ...C.headlineTags.map(
                            (h) => Tag(
                              h.toLowerCase().replaceAll(' ', '_'),
                              color: colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: IconBox(
                label: 'About me',
                color: colorScheme.primary,
                icon: Icons.elevator,
                child: MarkdownBody(data: C.elevator.join('\n')),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: IconBox(
                label: 'Skillset',
                color: colorScheme.tertiary,
                icon: Icons.handyman_outlined,
                child: Column(
                  crossAxisAlignment: .stretch,
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
                                colorScheme.primary,
                                // colorScheme.secondary,
                                colorScheme.tertiary,
                              ][i % 2],
                            ),
                          ),
                        ),
                        Tag('etc', color: colorScheme.secondary),
                      ],
                    ),
                    Divider(color: colorScheme.tertiary),
                    MarkdownBody(data: C.expertiseHeadline.join('\n')),
                  ],
                ),
              ),
            ),
          ],
        ),
        ...C.experience.map(
          (e) => Row(
            children: [
              Expanded(
                child: IconBox(
                  color: colorScheme.secondary,
                  label: 'Past Experience',
                  icon: Icons.work_history,
                  child: ExperienceView(
                    e,
                    isMobile: isMobile,
                    color: colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...C.education.map(
          (e) => Row(
            children: [
              Expanded(
                child: IconBox(
                  color: colorScheme.tertiary,
                  label: 'Education',
                  icon: Icons.work_history,
                  child: ExperienceView(
                    isMobile: isMobile,
                    e,
                    color: colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
        OverflowBar(
          alignment: .spaceEvenly,
          children: C.attributions
              .map(
                (e) => MarkdownBody(
                  data: e,
                  styleSheet: markdownBodyAs(context, (t) => t.labelMedium!),
                  onTapLink: onTapLink,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
