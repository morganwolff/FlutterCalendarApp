import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:flutter_calendar_app/pages/to_do_list/create_to_do_list/viewmodels/create_to_do_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'common/components/TabBarNavigation.dart';
import 'components/themes.dart';
import 'locals/app_locale.dart';


void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CalendarEventProvider()),
            ChangeNotifierProvider(create: (_) => CreateToDoListProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: const MyApp(),
      )
  );
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

  void setupLocalization()  {
    _localization.init(mapLocales: [
      const MapLocale('fr', AppLocale.FR),
      const MapLocale('en', AppLocale.EN),
      const MapLocale('es', AppLocale.ES),
      const MapLocale('kr', AppLocale.KR),
    ], initLanguageCode: 'en');
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  @override
  void initState() {
    setupLocalization();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Calendar App',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'EN'),
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      theme: themeProvider.isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
        home: const TabBarPage(),
        //home: const TestDirectoryStorage()
      //home: const LoginPage()
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
        automaticallyImplyLeading: false
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocale.currentLanguage.getString(context)),
            ElevatedButton(onPressed: () {
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
