import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:resume/pdf_constants.dart' as pc;
import 'package:resume/widgets/resume_pdf/resume.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:web/web.dart' as web;

class PdfButton extends StatefulWidget {
  final Widget widgetToExport;

  const PdfButton({super.key, required this.widgetToExport});

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
                      .textThemes(null)['bodyMedium']!
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
                      pw.Container(color: pc.ofBackgroundColor(context)),
                ),
                build: (context) => [Resume(image: img.buffer.asUint8List())],
              ),
            );

            var savedFile = await pdf.save();
            List<int> fileInts = List.from(savedFile);
            web.HTMLAnchorElement()
              ..href =
                  "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}"
              ..setAttribute(
                "download",
                "${DateTime.now().millisecondsSinceEpoch}.pdf",
              )
              ..click();

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
