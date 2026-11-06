import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:resume/widgets/brightness_toggle.dart';
import 'package:resume/widgets/pdf_button.dart';
import 'package:resume/constants.dart';
import 'package:resume/flutter_constants.dart';
import 'package:resume/pdf_constants.dart' as pdf;
import 'package:resume/widgets/resume/resume.dart';

void main() async {
  runApp(const ResumeApp());

  pdf.fonts['mono'] = .ttf(await rootBundle.load('fonts/Hack-Regular.ttf'));
  pdf.fonts['base'] = .ttf(await rootBundle.load('fonts/Lato-Regular.ttf'));
  pdf.fonts['italic'] = .ttf(await rootBundle.load('fonts/Lato-Italic.ttf'));
  pdf.fonts['boldItalic'] = .ttf(
    await rootBundle.load('fonts/Lato-SemiboldItalic.ttf'),
  );
  pdf.fonts['bold'] = .ttf(await rootBundle.load('fonts/Lato-Semibold.ttf'));
  pdf.fonts['icons'] = await PdfGoogleFonts.materialIcons();

}

class ResumeApp extends StatefulWidget {
  const ResumeApp({super.key});

  @override
  State<StatefulWidget> createState() => _ResumeAppState();
}

class _ResumeAppState extends State<ResumeApp> {
  ThemeMode themeMode = .system;

  void onBrightnessChanged(Brightness newBrightness) {
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
  }

  @override
  Widget build(BuildContext context) {
    final lrPadding = MediaQuery.of(context).size.width / 20;
    final tbPadding = MediaQuery.of(context).size.height / 20;

    final resume = Resume(onBrightnessChanged: onBrightnessChanged);

    return MaterialApp(
      title: 'Kevin Kays',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: Scaffold(
        body: SingleChildScrollView(
          clipBehavior: .none,
          child: SelectionArea(
            child: Center(
              child: Padding(
                padding: .only(left: spacing, right: spacing),
                child: ConstrainedBox(
                  constraints: .new(maxWidth: maxWidth),
                  child: Padding(
                    padding: .fromLTRB(
                      lrPadding,
                      tbPadding,
                      lrPadding,
                      tbPadding,
                    ),
                    child: resume,
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Wrap(
          spacing: spacing / 2,
          direction: .vertical,
          children: [
            BrightnessToggle(
              initialBrightness: MediaQuery.of(context).platformBrightness,
              onChanged: onBrightnessChanged,
            ),
            PdfButton(widgetToExport: resume),
          ],
        ),
      ),
    );
  }
}
