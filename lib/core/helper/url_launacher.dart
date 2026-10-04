import 'package:url_launcher/url_launcher.dart';

Future<void> openLink({required String link}) async {
  await launchUrl(Uri.parse(link));
}
