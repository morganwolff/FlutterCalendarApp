//import 'dart:html';
import 'dart:math';

mixin AppLocale {
  static const List<String> supportedLanguages = ['en', 'fr', 'es', 'kr'];
  static const List<String> actualLanguage = ['en', 'fr', 'es', 'kr'];

  static const String currentLanguage = "currentLanguage";
  static const String title = "title";
  static const String welcome = "welcome";
  static const String toDoLists = "toDoLists";
  static const String addToDoList = "addToDoList";
  static const String modifyToDoList = "modifyToDoList";
  static const String save = "save";
  static const String task = "task";
  static const String newElement = "newElement";
  static const String add = "add";
  static const String connection = "CONNECTION";
  static const String welcome_back = "WELCOME BACK TO YOUR CALENDAR";
  static const String student_id = "Student ID n°";
  static const String sign_in = "Sign In";
  static const String username = "Username";
  static const String sign_up = "Sign up";
  static const String confirm_id = "Confirm Student ID";
  static const String password = "Password";
  static const String return_login = "Return to Login";
  static const String not_matching = "Student IDs do not match.";
  static const String empty_pwd = "Password is empty.";
  static const String empty_id = "Student Id number is empty.";
  static const String error_con = "ERROR: E-mail";
  static const String fetching_event = "fetchingEvents";

  static const String calendar = "Calendar";
  static const String FCA = "Flutter Calendar APP";
  static const String planning = "Planning";
  static const String day = "Day";
  static const String week = "Week";
  static const String month = "Month";
  static const String personal = "Personal";
  static const String settings = "Settings";
  static const String new_event = "New event";
  static const String description = "Description";
  static const String a_d_event = "All day event";
  static const String start = "Start";
  static const String end = "End";
  static const String choose_color = "Choose color";
  static const String confirm = "Confirm";
  static const String add_to_calendar = "Add to calendar";
  static const String pink = "Pink";
  static const String red = "Red";
  static const String orange = "Orange";
  static const String yellow = "Yellow";
  static const String lightGreen = "Light Green";
  static const String green = "Green";
  static const String grey = "Grey";
  static const String purple = "Purple";
  static const String default_color = "Default color";
  static const String go_back = "Go back to settings";
  static const String select_lang = "select a language: ";
  static const String log_in = "Log in to Chung Ang";
  static const String mail_pwd = "Wrong E-mail or password";
  static const String sign_up_first = "Sign up first";
  static const String error_id = "ERROR: Id student number";
  static const String not_exist = "The CHUNG ANG student id number doesn't exist.";
  static const String error_username = "ERROR: Username";
  static const String four_chars = "Your Username must provide at least 4 characters.";
  static const String error_mail = "ERROR: E-mail";
  static const String enter_valid = "Enter a valid e-mail format.";
  static const String error_pwd = "ERROR: Password";
  static const String must_provide_four = "Your password must provide at least 4 characters.";
  static const String failed_to_load = 'Failed to load data';
  static const String already_used = 'The email is already used. You should change the email address.';
  static const String chungang = "chungang";

  static const Map<String, dynamic> EN = {
    currentLanguage:"en",
    title: "Title",
    welcome: "Welcome",
    toDoLists: "ToDo Lists",
    addToDoList: "Add a ToDo List",
    modifyToDoList: "Modify a ToDo List",
    task: "Task",
    newElement: "New element",
    add: "Add",
    chungang: "Chung Ang",
    fetching_event: "Fetching your meetings and events...",

    connection: "CONNECTION",
    welcome_back: "WELCOME BACK TO YOUR CALENDAR",
    student_id: "Student ID n°",
    sign_in: "Sign In",
    username: "Username",
    sign_up: "Sign Up",
    confirm_id: "Confirm Student ID",
    password: "Password",
    return_login: "Return to Login",
    not_matching: "Student IDs do not match.",
    empty_pwd: "Password is empty.",
    empty_id: "Student Id number is empty.",
    calendar: "Calendar",
    FCA: "Flutter Calendar APP",
    planning: "Planning",
    day: "Day",
    week: "Week",
    month: "Month",
    personal: "Personal",
    settings: "Settings",

    new_event: "New event",
    description: "Description",
    save: "Save",
    a_d_event: "All day event",
    start: "Start",
    end: "End",
    choose_color: "Choose color",
    confirm: "Confirm",
    add_to_calendar: "Add to calendar",
    pink: 'Pink',
    red: 'Red',
    orange: 'Orange',
    yellow: 'Yellow',
    lightGreen: 'Light Green',
    green: 'Green',
    grey: 'Grey',
    purple: "Purple",
    default_color: "Default color",
    go_back: "Go back to settings",
    select_lang: "Select a language: ",
    log_in: "Log in to Chung Ang",
    error_con: "ERROR: E-mail",
    mail_pwd: "Wrong E-mail or password",
    sign_up_first: "Subscribe first",
    error_id : "ERROR: Invalid student ID number",
    not_exist : "The CHUNG ANG student ID number doesn't exist.",
    error_username : "ERROR: Username",
    four_chars : "Your username must provide at least 4 characters.",
    enter_valid : "Enter a valid e-mail format.",
    error_pwd : "ERROR: Password",
    must_provide_four : "Your password must provide at least 4 characters.",
    failed_to_load : 'Failed to load data',
    already_used: 'The email is already used. You should change the email address.',


  };

  static const Map<String, dynamic> FR = {
    currentLanguage:"fr",
    title: "Titre",
    welcome: "Bienvenue",
    toDoLists: "Listes ToDo",
    addToDoList: "Ajouter une Liste ToDo",
    modifyToDoList: "Modifier une Liste",
    save: "Enregistrer",
    task: "Tâche",
    newElement: "Nouvel élément",
    add: "Ajouter",
    connection: "CONNEXION",
    welcome_back: "BIENVENUE DANS VOTRE CALENDRIER",
    student_id: "n° d'identification d'étudiant",
    sign_in: "Se Connecter",
    username: "Nom d'utilisateur",
    sign_up: "S'inscrire",
    confirm_id: "Confirmer Nº d'identification de l'étudiant",
    password: "Mot de passe",
    return_login: "Retour à la connexion",
    not_matching: "Les cartes d'identité des étudiants ne correspondent pas.",
    empty_pwd: "Le mot de passe est vide.",
    empty_id: "Le numéro d'identification de l'étudiant est vide.",
    chungang: "Chung Ang",
    fetching_event: "Récupération de vos réunions et événements...",

    calendar: "Calendrier",
    FCA: "Application Calendrier Flutter",
    planning: "Planification",
    day: "Jour",
    week: "Semaine",
    month: "Mois",
    personal: "Personnel",
    settings: "Paramètres",
    new_event: "Nouvel évènement",
    description: "Description",
    a_d_event: "Événement d'une journée",
    start:"Début",
    end: "Fin",
    choose_color: "Choisir la couleur",
    confirm: "Confirmer",
    add_to_calendar: "Ajouter au calendrier",
    pink: 'Rose',
    red: 'Rouge',
    orange: 'Orange',
    yellow: 'Jaune',
    lightGreen: 'Vert clair',
    green: 'Vert',
    grey: 'Gris',
    purple: "Violet",
    default_color: "Couleur par défaut",
    go_back: "Revenir aux paramètres",
    select_lang: "Sélectionnez une langue",
    log_in: "Connectez-vous à Chung Ang",
    error_con: "ERREUR: E-mail",
    mail_pwd: "E-mail ou mot de passe erroné",
    sign_up_first: "Abonnez-vous d'abord",
    error_id : "ERREUR : Numéro d'étudiant invalide",
    not_exist : "Le numéro d'étudiant CHUNG ANG n'existe pas.",
    error_username : "ERREUR : Nom d'utilisateur",
    four_chars : "Votre nom d'utilisateur doit comporter au moins 4 caractères.",
    enter_valid : "Entrez un format d'e-mail valide.",
    error_pwd : "ERREUR : Mot de passe",
    must_provide_four : "Votre mot de passe doit comporter au moins 4 caractères.",
    failed_to_load : 'Échec du chargement des données',
    already_used: "L'e-mail est déjà utilisé. Vous devriez changer l'adresse e-mail."


  };

  static const Map<String, dynamic> ES = {
    currentLanguage: "es",
    title: "Título",
    connection: "CONEXIÓN",
    welcome_back: "BIENVENIDO DE NUEVO A TU CALENDARIO",
    student_id: "Número de Identificación del Estudiante",
    sign_in: "Iniciar sesión",
    username: "Nombre de usuario",
    sign_up: "Registrarse",
    confirm_id: "Confirmar Número de Identificación del Estudiante",
    password: "Contraseña",
    return_login: "Volver al inicio de sesión",
    not_matching: "Los números de identificación del estudiante no coinciden.",
    empty_pwd: "La contraseña está vacía.",
    empty_id: "El número de identificación del estudiante está vacío.",
    toDoLists: "Listas de Tareas",
    addToDoList: "Agregar una Lista de Tareas",
    modifyToDoList: "Modificar una lista de tareas",
    task: "Tarea",
    newElement: "Nuevo Elemento",
    add: "Agregar",
    chungang: "Chung Ang",
    fetching_event: "Obteniendo sus reuniones y eventos...",

    calendar: "Calendario",
    FCA: "Aplicación de Calendario Flutter",
    planning: "Planificación",
    day: "Día",
    week: "Semana",
    month: "Mes",
    personal: "Personal",
    settings: "Configuración",

    new_event: "Nuevo evento",
    description: "Descripción",
    save: "Guardar",
    a_d_event: "Evento de todo el día",
    start: "Inicio",
    end: "Fin",
    choose_color: "Elegir color",
    confirm: "Confirmar",
    add_to_calendar: "Añadir al calendario",
    pink: 'Rosa',
    red: 'Rojo',
    orange: 'Naranja',
    yellow: 'Amarillo',
    lightGreen: 'Verde Claro',
    green: 'Verde',
    grey: 'Gris',
    purple: "Púrpura",
    default_color: "Color predeterminado",
    go_back: "Volver a configuración",
    select_lang: "Seleccionar un idioma: ",
    log_in: "Iniciar sesión en Chung Ang",
    error_con: "ERROR: Correo electrónico",
    mail_pwd: "Correo electrónico o contraseña incorrectos",
    sign_up_first: "Suscríbete primero",
    error_id: "ERROR: Número de identificación de estudiante no válido",
    not_exist: "El número de identificación de estudiante de CHUNG ANG no existe.",
    error_username: "ERROR: Nombre de usuario",
    four_chars: "Tu nombre de usuario debe tener al menos 4 caracteres.",
    enter_valid: "Ingresa un formato de correo electrónico válido.",
    error_pwd: "ERROR: Contraseña",
    must_provide_four: "Tu contraseña debe tener al menos 4 caracteres.",
    failed_to_load: 'Error al cargar los datos',
    already_used: 'El correo electrónico ya está en uso. Debes cambiar la dirección de correo electrónico.',

  };

  static const Map<String, dynamic> KR = {
    currentLanguage: "ko",
    title: "제목",
    connection: "연결",
    welcome_back: "캘린더에 다시 오신 것을 환영합니다",
    student_id: "학생 ID 번호",
    sign_in: "로그인",
    username: "사용자 이름",
    sign_up: "가입하기",
    confirm_id: "학생 ID 확인",
    password: "비밀번호",
    return_login: "로그인으로 돌아가기",
    not_matching: "학생 ID가 일치하지 않습니다.",
    empty_pwd: "비밀번호가 비어 있습니다.",
    empty_id: "학생 ID 번호가 비어 있습니다.",
    toDoLists: "할일 목록",
    addToDoList: "할일 목록 추가",
    modifyToDoList: "할일 목록 수정",
    task: "작업",
    newElement: "새로운 항목",
    add: "추가",
    chungang: "중앙",
    fetching_event: "회의 및 이벤트 가져오는 중...",

    calendar: "캘린더",
    FCA: "플러터 캘린더 앱",
    planning: "계획",
    day: "일",
    week: "주",
    month: "월",
    personal: "개인",
    settings: "설정",

    new_event: "새 이벤트",
    description: "설명",
    save: "저장",
    a_d_event: "하루 종일 이벤트",
    start: "시작",
    end: "종료",
    choose_color: "색상 선택",
    confirm: "확인",
    add_to_calendar: "캘린더에 추가",
    pink: '분홍',
    red: '빨강',
    orange: '주황',
    yellow: '노랑',
    lightGreen: '연두색',
    green: '초록',
    grey: '회색',
    purple: "보라",
    default_color: "기본 색상",
    go_back: "설정으로 돌아가기",
    select_lang: "언어 선택: ",
    log_in: "충앙대에 로그인",
    error_con: "오류: 이메일",
    mail_pwd: "잘못된 이메일 또는 비밀번호",
    sign_up_first: "먼저 가입하세요",
    error_id: "오류: 잘못된 학생 ID 번호",
    not_exist: "충앙대 학생 ID 번호가 존재하지 않습니다.",
    error_username: "오류: 사용자 이름",
    four_chars: "사용자 이름은 최소 4자 이상이어야 합니다.",
    enter_valid: "유효한 이메일 형식을 입력하세요.",
    error_pwd: "오류: 비밀번호",
    must_provide_four: "비밀번호는 최소 4자 이상이어야 합니다.",
    failed_to_load: '데이터를 불러오는 데 실패했습니다',
    already_used: '이 이메일은 이미 사용 중입니다. 이메일 주소를 변경해야 합니다.',

  };



  static Map<String, dynamic> currentLocale = EN;

  static void setLocale(String languageCode) {
    switch (languageCode) {
      case 'en':
        currentLocale = EN;
        break;
      case 'fr':
        currentLocale = FR;
        break;
      case 'es':
        currentLocale = ES;
        break;
      case 'kr':
        currentLocale = KR;
        break;
      default:
        currentLocale = EN;
        break;
    }
  }
}