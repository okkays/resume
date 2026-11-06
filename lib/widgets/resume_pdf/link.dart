import 'package:pdf/widgets.dart';
import 'package:resume/pdf_constants.dart';

class ResumeLink extends StatelessWidget {
  final String href;
  final String label;
  final Color backgroundColor;

  ResumeLink({
    required this.label,
    required this.href,
    required this.backgroundColor,
  });

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

    return UrlLink(
      child: Text(
        label,
        style: textThemes(
          backgroundColor.luminance > 0.4 ? Colors.indigo : Colors.amber,
        )['bodyMedium']!,
      ),
      destination: uri.toString(),
    );
  }
}
