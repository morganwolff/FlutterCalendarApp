/*import 'package:flutter/material.dart';
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
*/
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';
import 'package:flutter_calendar_app/components/textFieldLoginSubscribe.dart';
import 'package:provider/provider.dart';
import '../../../components/themes.dart';
import '../../../locals/local_storage.dart';
import '../../../locals/app_locale.dart';
import '../../login/views/Login.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = AppLocale.supportedLanguages[0];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.currentLocale[AppLocale.settings]),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocale.currentLocale[AppLocale.select_lang],
                  style: TextStyle(fontSize: 15),
                ),
                DropdownButton<String>(
                  value: selectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedLanguage = newValue;
                        AppLocale.setLocale(selectedLanguage);
                      });
                    }
                  },
                  items: AppLocale.supportedLanguages.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(AppLocale.currentLocale[AppLocale.log_in]),
            ),
            Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
            Text('Dark Mode'),
          ],
        ),
      ),
    );
  }
}
