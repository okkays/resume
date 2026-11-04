import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:intl/intl.dart';
import 'package:resume/brightness_toggle.dart';
import 'package:resume/content.dart';
import 'package:resume/icon_box.dart';
import 'package:resume/theme.dart';
import 'package:resume/constants.dart';
import 'package:resume/tag.dart';

const _verticalDivider = VerticalDivider(
  width: 20,
  thickness: 1,
  indent: 0,
  endIndent: 0,
  color: Colors.grey,
);

final _dateYm = DateFormat('MMM y');

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

class _ResumeState extends State<Resume> {
  @override
  Widget build(BuildContext context) {
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
        child: Image.asset(
          'images/me.jpg',
          height: isMobile ? query.size.width - query.size.width / 6 : 100,
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        clipBehavior: .none,
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
                        child: Column(
                          spacing: spacing / 2,
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .start,
                          children: [
                            Text(C.name, style: textTheme.titleLarge),
                            Text(C.jobTitle),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Text(C.email),
                                  _verticalDivider,
                                  Text(C.phone),
                                  _verticalDivider,
                                  Text(C.web),
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
                                    color: colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                        child: Expanded(
                          child: MarkdownBody(data: C.expertise.join('\n')),
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
                          child: ExperienceView(e),
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
                          child: EducationView(e),
                        ),
                      ),
                    ],
                  ),
                ),
                MarkdownBody(data: C.references),
              ],
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

class ExperienceView extends StatelessWidget {
  final Experience E;
  const ExperienceView(this.E, {super.key});

  @override
  Widget build(BuildContext context) {
    final String startDate = _dateYm.format(E.startDate);
    final String endDate = E.endDate != null
        ? _dateYm.format(E.endDate!)
        : 'present';
    return Wrap(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Text(E.company),
              Visibility(visible: E.jobTitle != null, child: _verticalDivider),
              Visibility(
                visible: E.jobTitle != null,
                child: Text(E.jobTitle ?? ''),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Text('$startDate - $endDate'),
              _verticalDivider,
              Text(E.location),
            ],
          ),
        ),
        Row(
          children: [Expanded(child: MarkdownBody(data: E.detail.join('\n')))],
        ),
      ],
    );
  }
}

class EducationView extends StatelessWidget {
  final Education E;
  const EducationView(this.E, {super.key});

  @override
  Widget build(BuildContext context) {
    final String startDate = _dateYm.format(E.startDate);
    final String endDate = E.endDate != null
        ? _dateYm.format(E.endDate!)
        : 'present';
    return Wrap(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Text(E.institution),
              _verticalDivider,
              Text(E.degreeOrCert),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Text('$startDate - ${E.endDatePrefix ?? ''}$endDate'),
              _verticalDivider,
              Text(E.location),
            ],
          ),
        ),
        Row(
          children: [Expanded(child: MarkdownBody(data: E.detail.join('\n')))],
        ),
      ],
    );
  }
}
