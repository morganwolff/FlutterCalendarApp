
import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/test_directory_storage/views/test_directory_storage_page.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'locals/app_locale.dart';
import 'locals/local_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() =>_MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FlutterLocalization _localization = FlutterLocalization.instance;

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  void setupLocalization() async {
    List? languages = await Devicelocale.preferredLanguages;
    String? language = 'en';
    if (languages?.first != null) {
      language = languages?.first.toString().substring(0, 2);
    }
    _localization.init(mapLocales: [
      const MapLocale('fr', AppLocale.FR),
      const MapLocale('en', AppLocale.EN),
    ], initLanguageCode: AppLocale.supportedLanguages.contains(language!)
        ? language
        : 'en');
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  @override
  void initState() {
    super.initState();
    setupLocalization();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      locale: const Locale('en', 'US'),
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestDirectoryStorage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocale.title.getString(context)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocale.currentLanguage.getString(context)),
            ElevatedButton(onPressed: () {
              final List<CalendarEvent> test = [
                const CalendarEvent(nb: 11, name: "pixy"),
                const CalendarEvent(nb: 32, name: "cipher")
              ];
              print(jsonEncode(test));
              setState(() {
                if (AppLocale.currentLanguage.getString(context) == "en") {
                  FlutterLocalization.instance.translate("fr");
                } else {
                  FlutterLocalization.instance.translate("en");
                }
              });
            }, child: const Text("change language")),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
