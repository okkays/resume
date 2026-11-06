import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume/constants.dart';
import 'package:resume/pdf_constants.dart' as pc;
import 'package:resume/widgets/resume_pdf/resume.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:web/web.dart' as web;

class PdfButton extends StatefulWidget {
  final Widget widgetToExport;
  final Brightness brightness;

  const PdfButton({
    super.key,
    required this.widgetToExport,
    required this.brightness,
  });

  @override
  State<StatefulWidget> createState() => _PdfButtonState();
}

class _PdfButtonState extends State<PdfButton> {
  IconData icon = Icons.save;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton.filled(
          onPressed: () async {
            setState(() {
              icon = Icons.hourglass_top;
            });

            final backgroundColor = widget.brightness == .light
                ? pc.fromColor(lightTheme.scaffoldBackgroundColor)
                : pc.fromColor(darkTheme.scaffoldBackgroundColor);

            final img = await rootBundle.load('images/me.jpg');
            final pw.ThemeData theme =
                .withFont(
                  base: pc.fonts['base'],
                  italic: pc.fonts['italic'],
                  bold: pc.fonts['bold'],
                  boldItalic: pc.fonts['boldItalic'],
                  icons: pc.fonts['icons'],
                ).copyWith(
                  bulletStyle: pc
                      .textThemes(backgroundColor.strokeColor)['bodyMedium']!
                      .copyWith(lineSpacing: 0),
                );

            final pdf = pw.Document(
              title: 'Kevin Kays - Resume',
              author: 'Kevin Kays',
              version: .pdf_1_5,
              compress: true,
              theme: theme,
            );

            pdf.addPage(
              pw.MultiPage(
                pageTheme: pw.PageTheme(
                  pageFormat: .letter,
                  orientation: .portrait,
                  theme: theme,
                  margin: pw.EdgeInsets.all(0),
                  textDirection: .ltr,
                  buildBackground: (context) =>
                      pw.Container(color: backgroundColor),
                ),
                build: (context) => [
                  Resume(
                    backgroundColor: backgroundColor,
                    colorScheme: widget.brightness == .light
                        ? lightTheme.colorScheme
                        : darkTheme.colorScheme,
                    image: img.buffer.asUint8List(),
                  ),
                ],
              ),
            );

            var savedFile = await pdf.save();
            List<int> fileInts = List.from(savedFile);
            final link = web.HTMLAnchorElement()
              ..href =
                  "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}"
              ..setAttribute("download", "Kevin Kays - Resume.pdf")
              ..setAttribute("target", "_blank")
              ..setAttribute("type", "hidden");
            web.document.body?.appendChild(link);
            link.dispatchEvent(web.MouseEvent('click', .new(bubbles: true, cancelable: true, view: web.window)));
            link.remove();

            setState(() {
              icon = Icons.save;
            });
          },
          icon: Icon(icon),
        ),
      ],
    );
  }
}
