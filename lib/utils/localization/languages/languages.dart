import '../../../template/base/template.dart';

class EnglishLocale {
  static const EN = <String, String>{
    //Rout names'
    AppRoutes.RouteToSplash: "Splash",
    AppRoutes.RouteToSignUp: "Sign Up",
    AppRoutes.RouteToMain: "Change Status",
    AppRoutes.RouteToInformation: "Information",
    AppRoutes.RouteToAdministrationAvailableShifts: "Administration",
    AppRoutes.RouteToAdministrationLocation: "Administration",
    AppRoutes.RouteToAdministrationUser: "Administration",
    AppRoutes.RouteToAvailableShift: "Administration",
    AppRoutes.RouteToChecklist: "Checklist",
    AppRoutes.RouteToDailyProgress: "Daily Progress",
    AppRoutes.RouteToStockSummary: "Stock Summary",
    AppRoutes.RouteToStockTransferItem: "Stock Transfer",
    AppRoutes.RouteToStockTransfer: "Stock Transfer",
    AppRoutes.RouteToTimesheet: "Timesheet",
    AppRoutes.RouteToAbout: "About",
    AppRoutes.RouteToTimesheetReq: "Timesheet Request",
    AppRoutes.RouteToTimesheetAvailable: "Availability",
    AppRoutes.RouteToMessages: "Messages",
    AppRoutes.RouteToProminentAlert: "Prominent Alert",
    AppRoutes.RouteToError: "Error",
    //Messages
    "welcome_back": "Welcome back @username!",
    "information": "Information",
    "close": "Close",
    "location_error": "Error occurred while getting device location!",
    "(test)": "(test)",
    "publish": "Publish",
    "unpublish": "Unpublish",
    "available_shifts": "Available Shifts",
    "guests": "Guests",
    "select_location": "Select Location",
    "all": "All",
    "empty_list": "The list is empty",
    "select_user": "Select a user",
    "shift_and_date": "Shift and Date",
    "save": "Save",
    "edit_first": "Please edit first!",
    "add": "Add",
    "comment": "Comment",
    "no_daily_progress": "No daily progress available!",
    "client": "Client",
    "select_client": "Select Client",
    "select_value": "Select Value",
    "status": "Status",
    "details": "Details",
    "timing": "Timing",
    "todays_activity": "Today's activity",
    "no_activity_today": "No activity today",
    "current_shifts": "Current shifts",
    "no_shifts_today": "No shifts today",
    "completed_shifts": "Completed shifts",
    "no_completed_shifts": "No completed shifts",
    "next_shifts": "Next shifts",
    "no_next_shifts": "No next shifts",
    "from": "From",
    "to": "to",
    "current_status": "Current Status",
    "current_location": "Current Location",
    "waiting_shift": "Waiting for Shift",
    "select_shift": "Select Shift",
    "last_page": "Last page",
    "first_page": "Initial page",
    "no_messages": "No Messages",
    "date": "Date",
    "sender": "Sender",
    "subject": "Subject",
    "no_content_selected": "No content selected!",
    "domain": "Domain",
    "username": "Username",
    "password": "Password",
    "register_now": "Register now",
    "_test": "test",
    "items": "Items",
    "total": "Total",
    "name": "Name",
    "please_set_items": "Please set items!",
    "in_stock": "In stock",
    "amount": "Amount",
    "amount_cannot_be_larger_than": "Amount cannot be larger than",
    "transfer_to": "Transfer to",
    "doc_num": "Document Number",
    "transfer": "Transfer",
    "select_warehouse": "Select Warehouse",
    "warning": "Warning",
    "unav_to_work": "Unavailable to work!",
    "fullday": "Fullday",
    "start_date": "Start date",
    "end_date": "End date",
    "cancel": "Cancel",
    "submit": "Submit",
    "new_req": "New request",
    "holiday": "Holiday",
    "hours": "Hours",
    "req_type": "Request Type",
    "time": "Time",
    "location": "Location",
    "shift": "Shift",
    "agreed_time": "Agreed Time",
    "actual_time": "Actual Time",
    "revoke": "Revoke",
    "want_to_revoke": "Do you want to Revoke?",
    "no": "No",
    "yes": "Yes",
    "leave_the_app": "Leave the app?",
    "availability": "Availability",
    "leave_the_app_warning":
        "Are you sure, you want to leave this application?",
    "start_and_end_dates_must_be_selected":
        "Start and End dates must be selected!",
    "reset": "Reset",
    "leave": "Leave",
    "stay": "Stay",

    //Custom Strings

    "location_not_found": "Location not found!",
    "selected_shift_not_in_range": "Selected shift is not in locations range!",
    "select_all": "Select All",
    'timer': 'Timer',
    "please_wait_loading": "Please wait, loading...",
    "normal_rate": "Normal Rate",
    "in_queue": "In Queue",
    'unknown': 'Unknown',
    'payment_rate': 'Payment Rate',
    'users': 'Users',
    'in_progress': 'In Progress',
    'notes': 'Notes',
    'search_for_property': 'Search for property',
    'properties': 'Properties',
    AppRoutes.RouteToProperties: "Properties",
    'rooms': 'Rooms',
    'storages': 'Storages',
    "start_time": "Start Time",
    "end_time": "End Time",
    "start_date_must_be_selected": "Start date must be selected!",
    "start_time_must_be_selected": "Start time must be selected!",
    "end_time_must_be_selected": "End time must be selected!",
    "unavailable_shift": "Unavailable Shift",
    "unavailable_shift_msg":
        "This shift cannot be selected, since it is unavailable right now!",
    "grant": "Grant",
    "deny": "Deny",
    "prominent_alert": "MCA needs your location",
    "prominent_alert_msg":
        "MCA used your location in the background. We use this to verify your location when you are signing in and out of shifts. We do not track your location.",
    "turn_on_loc": "Turn on location",
    "permanent_deny_handle_msg":
        "Go to Phone settings -> Apps -> My Cleaning App -> Permissions -> Location -> Allow only while using the app",
    "filter_warehouse": "Filter Warehouse",
    "error": "Error",
    "error_screen_msg":
        "We are sorry, there was an error! Send an email to inform us about it. The error will be automatically added to email if you press the above button to send email at @email",
    "openEmailApp": "Open Email App",
    "oops": "Oops! Something went wrong!",
  };
}

class HungarianLocale {
  static const HU = <String, String>{
    //Rout names'
    AppRoutes.RouteToSplash: "Splash",
    AppRoutes.RouteToSignUp: "Regisztráció",
    AppRoutes.RouteToMain: "Státusz váltás",
    AppRoutes.RouteToInformation: "Információk",
    AppRoutes.RouteToAdministrationAvailableShifts: "Adminisztráció",
    AppRoutes.RouteToAdministrationLocation: "Adminisztráció",
    AppRoutes.RouteToAdministrationUser: "Adminisztráció",
    AppRoutes.RouteToAvailableShift: "Adminisztráció",
    AppRoutes.RouteToChecklist: "Ellenőrzőlista",
    AppRoutes.RouteToDailyProgress: "Napi Folyamat",
    AppRoutes.RouteToStockSummary: "Készlet összesítés",
    AppRoutes.RouteToStockTransferItem: "Készletátadás",
    AppRoutes.RouteToStockTransfer: "Készletátadás",
    AppRoutes.RouteToTimesheet: "Jelenléti ív",
    AppRoutes.RouteToAbout: "Névjegy",
    AppRoutes.RouteToTimesheetReq: "Kérelem",
    AppRoutes.RouteToTimesheetAvailable: "Elérhetőség",
    AppRoutes.RouteToMessages: "Üzenetek",
    //Messages
    "welcome_back": "Üdvözöljük @username!",
    "information": "Információk",
    "close": "Bezárás",
    "location_error": "Hiba történt az eszköz helyének meghatározása során!",
    "publish": "Közzétesz",
    "unpublish": "Közzététel visszavonása",
    "available_shifts": "Elérhető beosztások",
    "guests": "Vendégek:",
    "select_location": "Válassza a Hely lehetőséget",
    "all": "Mind",
    "empty_list": "A lista üres",
    "select_user": "Válasszon egy felhasználót",
    "shift_and_date": "Shift és dátum",
    "save": "Mentés",
    "edit_first": "Kérjük, előbb szerkessze!",
    "add": "Hozzáadás",
    "comment": "Megjegyzés",
    "no_daily_progress": "Nincs elérhető adat a napi folyamatokról",
    "client": "Kliens",
    "select_client": "Válassza az Ügyfél lehetőséget",
    "select_value": "Válassza az Érték lehetőséget",
    "status": "Státusz",
    "details": "Részletek",
    "timing": "Időbeosztás",
    "todays_activity": "Mai aktivitás",
    "no_activity_today": "Nincs mai aktivitás",
    "current_shifts": "Aktuális műszakok",
    "no_shifts_today": "Nincs aktuális műszak",
    "completed_shifts": "Befejezett műszakok",
    "no_completed_shifts": "Nincs befejezett műszak",
    "next_shifts": "Következő műszakok",
    "no_next_shifts": "Nincs elérhető jövőbeli műszak",
    "from": "Tól től",
    "to": "nak nek",
    "current_status": "Aktuális státus",
    "current_location": "Aktuális helyzet:",
    "waiting_shift": "Várakozás",
    "select_shift": "Válasszon műszakot",
    "last_page": "Utolsó oldal",
    "first_page": "Kezdő oldal",
    "no_messages": "Nincs megjeleníthető üzenet",
    "date": "Dátum",
    "sender": "Feladó",
    "subject": "Téma",
    "no_content_selected":
        "Nincs megjeleníthető tartalom. Kérjük válasszon egy üzenetet.",
    "domain": "Domain név",
    "username": "Felhasználói név",
    "password": "Jelszó",
    "register_now": "Regisztrálás",
    "_test": "teszt",
    "items": "Termékek",
    "total": "Összesen",
    "name": "Név",
    "please_set_items": "Kérjük adja meg az átvitelre váró tételeket",
    "in_stock": "Raktáron",
    "amount": "Aktuális készlet",
    "amount_cannot_be_larger_than": "Az összeg nem lehet nagyobb, mint ",
    "transfer_to": "Átszállít",
    "doc_num": "Dokumentum száma",
    "transfer": "Átszállít",
    "select_warehouse": "Válasszon raktárat",
    "warning": "Figyelem",
    "unav_to_work": "Nem áll rendelkezésre",
    "fullday": "Teljes nap",
    "start_date": "Kezdő dátum",
    "end_date": "Végső dátum",
    "cancel": "Mégsem",
    "submit": "Elküld",
    "new_req": "Új kérelem",
    "holiday": "Ünnep",
    "hours": "Óra",
    "req_type": "Kérelem típusa",
    "time": "Idő",
    "location": "Hely",
    "shift": "Beosztás",
    "agreed_time": "Munkaidő",
    "actual_time": "Valós idő",
    "revoke": "Visszavon",
    "want_to_revoke": "Beosztás felmentés visszavonása",
    "no": "Nem",
    "yes": "Igen",
    "leave_the_app": "Kilép az alkalmazásból?",
    "availability": "Biztos benne hogy ki akar lépni az alkalmazásból?",
    "leave_the_app_warning":
        "Biztos benne, hogy ki akar lépni ebből az alkalmazásból?",
    "start_and_end_dates_must_be_selected":
        "Ki kell választani a kezdési és befejezési dátumot!",
    "reset": "Visszaállítás",
    "leave": "Kilépés",
    "stay": "Maradj",

    //Custom Strings
    "location_not_found": "A hely nem található!",
    "selected_shift_not_in_range":
        "A kiválasztott műszak nincs a tartományban!",
    "select_all": "Mindet kiválaszt",
    'timer': 'Időzítő',
    "please_wait_loading": "Kérjük, várjon, betöltés...",
    "normal_rate": "Normál arány",
    "in_queue": "Sorban",
    'unknown': 'Ismeretlen',
    'payment_rate': 'Fizetési arány',
    'users': 'Felhasználók',
    'in_progress': 'Folyamatban',
    'notes': 'Megjegyzések',
    'search_for_property': 'Ingatlan keresése',
    'properties': 'Tulajdonságok',
    AppRoutes.RouteToProperties: "Tulajdonságok",
    'rooms': 'Szobák',
    'storages': 'Tárolók',
    "start_time": "Kezdési idő",
    "end_time": "Idő vége",
    "start_date_must_be_selected": "A kezdési dátumot ki kell választani!",
    "start_time_must_be_selected": "Kezdési időpontot kell kiválasztani!",
    "end_date_must_be_selected": "A befejezési időpontot ki kell választani!",
    "unavailable_shift": "Nem elérhető Shift",
    "unavailable_shift_msg": "Ez a műszak nem választható, mert nem elérhető!",
  };
}

class PortugueseLocale {
  static const PT = <String, String>{
    AppRoutes.RouteToSplash: "Splash",
    AppRoutes.RouteToSignUp: "Registo",
    AppRoutes.RouteToMain: "Alterar O Estado",
    AppRoutes.RouteToInformation: "Informacao",
    AppRoutes.RouteToAdministrationAvailableShifts: "Administração",
    AppRoutes.RouteToAdministrationLocation: "Administração",
    AppRoutes.RouteToAdministrationUser: "Administração",
    AppRoutes.RouteToAvailableShift: "Administração",
    AppRoutes.RouteToChecklist: "Verificacao",
    AppRoutes.RouteToDailyProgress: "Progresso Diário",
    AppRoutes.RouteToStockSummary: "Resumo de ações",
    AppRoutes.RouteToStockTransferItem: "Transferência de estoque",
    AppRoutes.RouteToStockTransfer: "Transferência de estoque",
    AppRoutes.RouteToTimesheet: "Planilha de horário",
    AppRoutes.RouteToAbout: "Sobre",
    AppRoutes.RouteToTimesheetReq: "Solicitação",
    AppRoutes.RouteToTimesheetAvailable: "Disponibilidade",
    AppRoutes.RouteToMessages: "Mensagens",
    //Messages
    "welcome_back": "Bemüvindo de volta @username!",
    "information": "Informacao",
    "close": "Perto",
    "location_error": "Ocorreu um erro ao obter a localização do dispositivo!",
    "publish": "",
    "unpublish": "Publicar",
    "available_shifts": "Cancelar Publicação",
    "guests": "Lista de turnos disponíveis",
    "select_location": "Convidados",
    "all": "Selecionar local",
    "empty_list": "Tudo",
    "select_user": "A lista está vazia",
    "shift_and_date": "Por favor seleccione um utilizador",
    "save": "Turno e Data",
    "edit_first": "Salvar",
    "add": "Por favor, edite primeiro!",
    "comment": "Adicionar",
    "no_daily_progress": "Comentario",
    "client": "Não há dados de progresso diários disponíveis",
    "select_client": "Cliente",
    "select_value": "Selecionar cliente",
    "status": "Selecione o valor",
    "details": "Status",
    "timing": "Detalhes",
    "todays_activity": "Cronometragens",
    "no_activity_today": "Actividade de hoje",
    "current_shifts": "Nenhuma actividade hoje",
    "no_shifts_today": "Mudanças Actuais",
    "completed_shifts": "Não está disponível nenhum deslocamento actual",
    "no_completed_shifts": "Mudanças Completas",
    "next_shifts": "Sem deslocamento completo",
    "no_next_shifts": "Turnos Seguintes",
    "from": "Nenhuma mudança disponível no futuro",
    "to": "A partir de",
    "current_status": "para",
    "current_location": "Status atual",
    "waiting_shift": "Localização actual",
    "select_shift": "À espera de",
    "last_page": "Seleccione por favor um shift",
    "first_page": "Última página",
    "no_messages": "Página inicial",
    "date": "Nenhuma mensagem disponível",
    "sender": "Data",
    "subject": "Remetente",
    "no_content_selected": "Sujeito",
    "domain": "Nenhum conteúdo, por favor selecione uma mensagem",
    "username": "Dominio",
    "password": "Usuário",
    "register_now": "Senha",
    "_test": "test",
    "items": "teste",
    "total": "Itens",
    "name": "Total",
    "please_set_items": "Nome",
    "in_stock": "Defina os itens a serem transferidos",
    "amount": "Em estoque",
    "amount_cannot_be_larger_than": "Estoque atual",
    "transfer_to": "O valor não pode ser maior que",
    "doc_num": "Transferir",
    "transfer": "Número do documento",
    "select_warehouse": "Transferir",
    "warning": "Por favor, selecione um armazém",
    "unav_to_work": "Aviso",
    "fullday": "Não disponível para trabalhar",
    "start_date": "Dia inteiro",
    "end_date": "Data de início",
    "cancel": "Data final",
    "submit": "Cancelar",
    "new_req": "Submeter",
    "holiday": "Novo pedido",
    "hours": "Feriado",
    "req_type": "Horas",
    "time": "Tipo de solicitação",
    "location": "Tempo",
    "shift": "Localização",
    "agreed_time": "Mudança",
    "actual_time": "Hora acordada",
    "revoke": "Hora acordada",
    "want_to_revoke": "Revogar",
    "no": "Revogar turno de liberação",
    "yes": "Não",
    "leave_the_app": "Sim",
    "availability": "Deixar a aplicação?",
    "leave_the_app_warning":
        "Tens a certeza que queres deixar esta candidatura?",
    "start_and_end_dates_must_be_selected":
        "Tem certeza de que deseja sair deste aplicativo?",
    "reset": "Resetar",
    "leave": "Sair",
    "stay": "Permanecer",

    //Custom Strings

    "location_not_found": "Endtime deve ser selecionado!",
    "selected_shift_not_in_range":
        "O turno selecionado não está no intervalo de locais!",
    "select_all": "Selecionar tudo",
    'timer': 'Cronômetro',
    "please_wait_loading": "Aguarde, carregando...",
    "normal_rate": "Taxa normal",
    "in_queue": "Na fila",
    'unknown': 'Desconhecido',
    'payment_rate': 'Taxa de pagamento',
    'users': 'Comercial',
    'in_progress': 'Em andamento',
    'notes': 'Notas',
    'search_for_property': 'Pesquisar propriedade',
    'properties': 'Propriedades',
    AppRoutes.RouteToProperties: "Propriedades",
    'rooms': 'Quartos',
    'storages': 'Armazenamentos',
    "start_time": "Hora de início",
    "end_time": "Fim do tempo",
    "start_date_must_be_selected": "A data de início deve ser selecionada!",
    "start_time_must_be_selected": "A hora de início deve ser selecionada!",
    "end_time_must_be_selected": "A hora de término deve ser selecionada!",
    "unavailable_shift": "O turno não está disponível!",
    "unavailable_shift_msg":
        "Este turno não pode ser selecionado, pois não está disponível!",
  };
}
