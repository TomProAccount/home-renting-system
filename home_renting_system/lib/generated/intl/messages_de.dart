// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(role) => "✅ Angemeldet als ${role}";

  static String m1(role) => "✅ Registriert als ${role}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Bestätigen Sie Ihr Passwort",
    ),
    "enterConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Geben Sie Ihr Passwort erneut ein",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage(
      "Geben Sie Ihre E-Mail ein",
    ),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Geben Sie Ihr Passwort ein",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Geben Sie eine gültige E-Mail ein",
    ),
    "goToLogin": MessageLookupByLibrary.simpleMessage("Zur Anmeldung"),
    "goToRegister": MessageLookupByLibrary.simpleMessage("Zur Registrierung"),
    "landlord": MessageLookupByLibrary.simpleMessage("Vermieter"),
    "loggedInAs": m0,
    "login": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "loginError": MessageLookupByLibrary.simpleMessage("❌"),
    "min8Chars": MessageLookupByLibrary.simpleMessage(
      "Mindestens 8 Zeichen erforderlich",
    ),
    "mustContainNumber": MessageLookupByLibrary.simpleMessage(
      "Mindestens eine Zahl erforderlich",
    ),
    "mustContainSpecialChar": MessageLookupByLibrary.simpleMessage(
      "Mindestens ein Sonderzeichen erforderlich",
    ),
    "mustContainUppercase": MessageLookupByLibrary.simpleMessage(
      "Mindestens ein Großbuchstabe erforderlich",
    ),
    "mustNotContainSpaces": MessageLookupByLibrary.simpleMessage(
      "Darf keine Leerzeichen oder Tabs enthalten",
    ),
    "noHousesyet": MessageLookupByLibrary.simpleMessage("Noch keine Häuser"),
    "notAutorise": MessageLookupByLibrary.simpleMessage(
      "🚫 Sie sind nicht berechtigt, diese Seite anzusehen",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "❌ Passwörter stimmen nicht überein",
    ),
    "pleaseEnterEmail": MessageLookupByLibrary.simpleMessage(
      "Bitte geben Sie Ihre E-Mail ein",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Bitte geben Sie Ihr Passwort ein",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Registrieren"),
    "registeredAs": m1,
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "❌ Etwas ist schief gelaufen",
    ),
    "student": MessageLookupByLibrary.simpleMessage("Student"),
    "yourEmail": MessageLookupByLibrary.simpleMessage("Ihre E-Mail"),
    "yourHouses": MessageLookupByLibrary.simpleMessage("Ihre Häuser"),
    "yourPassword": MessageLookupByLibrary.simpleMessage("Ihr Passwort"),
  };
}
