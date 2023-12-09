import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';
import 'package:provider/provider.dart';
import '../../../components/themes.dart';
import '../../../locals/cache.dart';

class Identifiers extends StatefulWidget {
  const Identifiers({super.key});

  @override
  State<Identifiers> createState() => _IdentifiersState();
}

class _IdentifiersState extends State<Identifiers> {

  Future<String?> getStudentID(BuildContext context) async {
    var studentId = await Cache.getStringFromCache(Cache.studentId, Cache.studentIdTimeStamp);
    return studentId;
  }

  Future<String?> getStudentName(BuildContext context) async {
    var studentName = await Cache.getStringFromCache(Cache.username, Cache.usernameTimeStamp);
    return studentName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: Future.wait([
            getStudentID(context), // Future that returns String?
            getStudentName(context), // Future that returns String?
          ]),
          builder: (
              BuildContext context,
              AsyncSnapshot<List<String?>> snapshot,
              ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.any((element) => element == null)) {
              // Handling the case where any of the futures returns null
              return Center(child: Text('Missing data'));
            } else {
              // Assuming that we now have all the data and none of it is null
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data![1]!, style: Theme.of(context).textTheme.headlineMedium),
                  Text(snapshot.data![0]!, style: Theme.of(context).textTheme.bodyMedium),
                ],
              );
            }
          },
        );
  }
}



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
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: Image.asset('assets/LogoCAU2.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Identifiers(),
              const SizedBox(height: 20),
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
