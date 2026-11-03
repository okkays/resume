import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:intl/intl.dart';
import 'package:resume/data.dart';

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

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kevin Kays - Resume',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const Resume(),
    );
  }
}

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: .start,
              children: [
                CircleAvatar(
                  radius: 100,
                  foregroundImage: AssetImage('images/me.jpg'),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(C.name),
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
                      Text(C.headline),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: MarkdownBody(data: C.elevator.join('\n'))),
              ],
            ),
            Row(children: [Expanded(child: Text('Skillset'))]),
            Row(
              children: [
                Expanded(child: MarkdownBody(data: C.expertise.join('\n'))),
              ],
            ),
            Row(children: [Expanded(child: Text('Past Experience'))]),
            ...C.experience.map((e) => ExperienceView(e)),
            ...C.education.map((e) => EducationView(e)),
            MarkdownBody(data: C.references),
          ],
        ),
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
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Text(E.company),
                Visibility(
                  visible: E.jobTitle != null,
                  child: _verticalDivider,
                ),
                Visibility(
                  visible: E.jobTitle != null,
                  child: Text(E.jobTitle ?? ''),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Text('$startDate - $endDate'),
                _verticalDivider,
                Text(E.location),
              ],
            ),
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
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Text(E.institution),
                _verticalDivider,
                Text(E.degreeOrCert),
              ],
            ),
          ),
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              children: [
                Text('$startDate - ${E.endDatePrefix ?? ''}$endDate'),
                _verticalDivider,
                Text(E.location),
              ],
            ),
          ),
        ),
        Row(
          children: [Expanded(child: MarkdownBody(data: E.detail.join('\n')))],
        ),
      ],
    );
  }
}
