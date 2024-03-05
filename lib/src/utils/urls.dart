import 'package:url_launcher/url_launcher.dart';


Future<void> launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'No se puede abrir $url';
  }
}



void sendEmails(){
   final Uri emailLaunchUri = Uri(
     scheme: 'mailto',
     path: 'soporte@neitor.com',
     queryParameters: {
      'subject': '',
      'body': ''
     },
    );
   launchUrl(emailLaunchUri);
}