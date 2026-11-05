import 'package:flutter/material.dart';

class PdfButton extends StatefulWidget {
  final Widget widgetToExport;

  const PdfButton({
    super.key,
    required this.widgetToExport,
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
