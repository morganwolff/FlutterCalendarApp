import 'package:firebase_auth/firebase_auth.dart';
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
            getStudentID(context),
            getStudentName(context),
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
              return Center(child: Text('Missing data'));
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data![1]!, style: Theme.of(context).textTheme.headlineMedium),
                  Text(snapshot.data![0]!, style: Theme.of(context).textTheme.titleMedium),
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

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocale.deconnexion_alert_title.getString(context)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Expanded(  // Utilisez Expanded ici
                    child: Column(
                      children: [
                        Text(AppLocale.deconnexion_alert_text.getString(context),
                          style: const TextStyle(fontSize: 16),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text(AppLocale.deconnexion_alert_cancel_button.getString(context)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text(AppLocale.deconnexion_alert_confirm_button.getString(context)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

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
          padding: const EdgeInsets.all(20.0),
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
                  Text("${AppLocale.change_theme.getString(context)}    ${themeProvider.isDarkMode ? AppLocale.theme_dark.getString(context) : AppLocale.theme_light.getString(context)}", style: TextStyle(fontSize: 16),),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocale.select_lang.getString(context), style: TextStyle(fontSize: 16),),
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
                  Text(AppLocale.deconnexion.getString(context), style: TextStyle(fontSize: 16),),
                  IconButton(
                      onPressed: () => _showMyDialog(context),
                      icon: Icon(Icons.logout, size: 32,)
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
