import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../locals/app_locale.dart';
import '../../../locals/local_storage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Settings Page"),
            ElevatedButton(onPressed: () {
              if (AppLocale.currentLanguage.getString(context) == "en") {
                FlutterLocalization.instance.translate("fr");
              } else {
                FlutterLocalization.instance.translate("en");
              }
            }, child: const Text("change language")),
          ],
        ),
      ),
    );
  }
}