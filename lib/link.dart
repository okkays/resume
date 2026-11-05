import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ResumeLink extends StatelessWidget {
  final String href;
  final String label;

  const ResumeLink({required this.label, required this.href, super.key});

  @override
  Widget build(BuildContext context) {
    Uri uri;
    if (href.startsWith('tel:')) {
      uri = Uri(scheme: 'tel', path: href.split(':').last);
    } else if (href.startsWith('mailto:')) {
      uri = Uri(scheme: 'mailto', path: href.split(':').last);
    } else {
      uri = Uri.https(href);
    }

    return Column(
      children: [
        Link(
          uri: uri,
          target: .blank,
          builder: (context, _) => Text(
            label,
            style: TextTheme.of(context).bodyMedium!.copyWith(
              color: Theme.of(context).brightness == .dark
                  ? Colors.amber
                  : Colors.indigo,
            ),
          ),
        ),
      ],
    );
  }
}
