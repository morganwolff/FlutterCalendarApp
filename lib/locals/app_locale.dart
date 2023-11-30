mixin AppLocale {
  static const List<String> supportedLanguages = ['en', 'fr'];

  static const String currentLanguage = "currentLanguage";
  static const String title = "title";
  static const String welcome = "welcome";

  static const Map<String, dynamic> EN = {
    currentLanguage:"en",
    title: "Title",
    welcome: "Welcome"
  };

  static const Map<String, dynamic> FR = {
    currentLanguage:"fr",
    title: "Titre",
    welcome: "Bienvenue"
  };
}