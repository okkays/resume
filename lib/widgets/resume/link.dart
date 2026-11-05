import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return InkWell(
      child: Text(
        label,
        style: TextTheme.of(context).bodyMedium!.copyWith(
          color: Theme.of(context).brightness == .dark
              ? Colors.amber
              : Colors.indigo,
        ),
      ),
      onTap: () => launchUrl(uri),
    );
  }
}

Future<void> onTapLink(String text, String? href, String title) async {
  if (href != null) {
    await launchUrl(Uri.parse(href));
  }
}
