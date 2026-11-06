import 'package:pdf/widgets.dart';
import 'package:resume/pdf_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeLink extends StatelessWidget {
  final String href;
  final String label;

  ResumeLink({required this.label, required this.href});

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

    return Link(
      child: Text(
        label,
        style: textThemes(context)['bodyMedium']!.copyWith(
          color: ofBrightness(context) == .dark ? Colors.amber : Colors.indigo,
        ),
      ),
      destination: uri.toString(),
    );
  }
}

Future<void> onTapLink(String text, String? href, String title) async {
  if (href != null) {
    await launchUrl(Uri.parse(href));
  }
}
