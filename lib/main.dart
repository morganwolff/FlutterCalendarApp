
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Pages/login_page/views/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_calendar_app/firebase_options.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'Pages/login_page/models/UserInformationModel.dart';
import 'locals/app_locale.dart';
import 'locals/local_storage.dart';
import 'package:provider/provider.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInformationModel()),
      ],
      child: MyApp(),
    ),
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return const  MyHomePage();
          }
          else {
            return const LoginPage();
          }

        },
      ),
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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: ()
          {
            FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              height: 250,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Consumer<UserInformationModel>(
                builder: (context, userInfoModel, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Username: ${userInfoModel.username}'),
                      Text('Student ID: ${userInfoModel.studentId}'),
                      Text('Planning Cau: ${userInfoModel.planningCau.toString()}'),
                    ],
                  );
                },
              ),
            ),


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
