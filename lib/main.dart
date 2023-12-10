import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/Pages/login_page/views/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_calendar_app/firebase_options.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'Pages/login_page/models/UserInformationModel.dart';
import 'locals/app_locale.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:flutter_calendar_app/pages/to_do_list/create_to_do_list/viewmodels/create_to_do_list_provider.dart';
import 'common/components/TabBarNavigation.dart';
import 'components/themes.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CalendarEventProvider()),
          ChangeNotifierProvider(create: (_) => CreateToDoListProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => UserInformationModel()),
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
    themeProvider.initDarkMode();
    return MaterialApp(
      title: 'Calendar App',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'EN'),
      supportedLocales: _localization.supportedLocales,
      localizationsDelegates: _localization.localizationsDelegates,
      theme: themeProvider.isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return const  TabBarPage();
          }
          else {
            return const LoginPage();
          }

        },
      ),
    );
  }
}