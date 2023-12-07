import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyLink extends StatelessWidget {
  const PrivacyPolicyLink({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          _launchURL();
        },
        child: const Text(
          'Política de Privacidade',
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

void _launchURL() async {
  Uri url = Uri.parse('https://www.google.com');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Não foi possível abrir o link: $url';
  }
}
