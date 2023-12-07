mixin AppLocale {
  static const List<String> supportedLanguages = ['en', 'fr'];

  static const String currentLanguage = "currentLanguage";
  static const String title = "title";
  static const String welcome = "welcome";
  static const String toDoLists = "toDoLists";
  static const String addToDoList = "addToDoList";
  static const String save = "save";
  static const String task = "task";
  static const String newElement = "newElement";
  static const String add = "add";


  static const Map<String, dynamic> EN = {
    currentLanguage:"en",
    title: "Title",
    welcome: "Welcome",
    toDoLists: "ToDo Lists",
    addToDoList: "Add a ToDo List",
    save: "Save",
    task: "Task",
    newElement: "New element",
    add: "Add",
  };

  static const Map<String, dynamic> FR = {
    currentLanguage:"fr",
    title: "Titre",
    welcome: "Bienvenue",
    toDoLists: "Listes ToDo",
    addToDoList: "Ajouter une Liste ToDo",
    save: "Enregistrer",
    task: "Tâche",
    newElement: "Nouvel élément",
    add: "Ajouter",
  };
}