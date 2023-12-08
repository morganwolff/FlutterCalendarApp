import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';
import 'package:provider/provider.dart';
import '../../../components/themes.dart';

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
        title: Text(AppLocale.settings.getString(context)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocale.select_lang.getString(context),),
                  DropdownButton<String>(
                    value: AppLocale.currentLanguage.getString(context),
                    onChanged: (String? newValue) {
                      setState(() {
                        FlutterLocalization.instance.translate(newValue!);
                        selectedLanguage = newValue;
                      });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${AppLocale.change_theme.getString(context)}    ${themeProvider.isDarkMode ? AppLocale.theme_dark.getString(context) : AppLocale.theme_light.getString(context)}"),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
