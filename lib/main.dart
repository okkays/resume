import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:resume/brightness_toggle.dart';
import 'package:resume/content.dart';
import 'package:resume/icon_box.dart';
import 'package:resume/theme.dart';
import 'package:resume/constants.dart';
import 'package:resume/tag.dart';
import 'package:collection/collection.dart';
import 'package:resume/experience_view.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatefulWidget {
  const ResumeApp({super.key});

  @override
  State<StatefulWidget> createState() => _ResumeAppState();
}

class _ResumeAppState extends State<ResumeApp> {
  ThemeMode themeMode = .system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kevin Kays - Resume',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: Resume(
        onBrightnessChanged: (newBrightness) {
          switch (newBrightness) {
            case .light:
              setState(() {
                themeMode = .light;
              });
            case .dark:
              setState(() {
                themeMode = .dark;
              });
          }
        },
      ),
    );
  }
}

class Resume extends StatefulWidget {
  final ValueChanged<Brightness> onBrightnessChanged;

  const Resume({super.key, required this.onBrightnessChanged});

  @override
  State<Resume> createState() => _ResumeState();
}

final List<String> images = [
  'images/me.jpg',
  'images/lua.png',
  'images/code.png',
];

class _ResumeState extends State<Resume> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    for (var image in images) {
      precacheImage(AssetImage(image), context);
    }

    final query = MediaQuery.of(context);
    final textTheme = TextTheme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile = query.size.width < 500;
    final isDesktop = !isMobile;

    final lrPadding = query.size.width / 20;
    final tbPadding = query.size.height / 20;

    final W = (
      avatar: ClipRRect(
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
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          clipBehavior: .none,
          child: ConstrainedBox(
            constraints: .new(maxWidth: maxWidth),
            child: Padding(
              padding: .fromLTRB(lrPadding, tbPadding, lrPadding, tbPadding),
              child: SelectionArea(
                child: Column(
                  spacing: spacing,
                  children: [
                    Visibility(visible: isMobile, child: W.avatar),
                    IntrinsicHeight(
                      child: Row(
                        spacing: spacing / 2,
                        crossAxisAlignment: isMobile ? .start : .stretch,
                        children: [
                          Visibility(visible: isDesktop, child: W.avatar),
                          Expanded(
                            child: Padding(
                              padding: .only(right: spacing / 2),
                              child: Column(
                                spacing: spacing / 2,
                                mainAxisAlignment: .center,
                                crossAxisAlignment: isDesktop
                                    ? .start
                                    : .stretch,
                                children: [
                                  Text(C.name, style: textTheme.headlineMedium),
                                  FittedBox(
                                    fit: .fitWidth,
                                    child: Text(
                                      C.jobTitle,
                                      style: textTheme.headlineSmall,
                                    ),
                                  ),
                                  FittedBox(
                                    fit: .fitWidth,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Text(C.email),
                                          verticalDivider,
                                          Text(C.phone),
                                          verticalDivider,
                                          Text(C.web),
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
                                MarkdownBody(
                                  data: C.expertiseHeadline.join('\n'),
                                ),
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
                    MarkdownBody(data: C.references),

                    OverflowBar(
                      alignment: .spaceEvenly,
                      children: C.attributions
                          .map(
                            (e) => MarkdownBody(
                              data: e,
                              styleSheet: markdownBodyAs(
                                context,
                                (t) => t.labelMedium!,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BrightnessToggle(
        initialBrightness: MediaQuery.of(context).platformBrightness,
        onChanged: widget.onBrightnessChanged,
      ),
    );
  }
}
