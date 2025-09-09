// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(role) => "✅ Connecté en tant que ${role}";

  static String m1(role) => "✅ Enregistré en tant que ${role}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmez votre mot de passe",
    ),
    "enterConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Entrez à nouveau votre mot de passe",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Entrez votre email"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Entrez votre mot de passe",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Entrez un email valide",
    ),
    "goToLogin": MessageLookupByLibrary.simpleMessage("Aller à la connexion"),
    "goToRegister": MessageLookupByLibrary.simpleMessage(
      "Aller à l\'inscription",
    ),
    "landlord": MessageLookupByLibrary.simpleMessage("Propriétaire"),
    "loggedInAs": m0,
    "login": MessageLookupByLibrary.simpleMessage("Connexion"),
    "loginError": MessageLookupByLibrary.simpleMessage("❌"),
    "min8Chars": MessageLookupByLibrary.simpleMessage(
      "Doit contenir au moins 8 caractères",
    ),
    "mustContainNumber": MessageLookupByLibrary.simpleMessage(
      "Doit contenir au moins un chiffre",
    ),
    "mustContainSpecialChar": MessageLookupByLibrary.simpleMessage(
      "Doit contenir au moins un caractère spécial",
    ),
    "mustContainUppercase": MessageLookupByLibrary.simpleMessage(
      "Doit contenir au moins une majuscule",
    ),
    "mustNotContainSpaces": MessageLookupByLibrary.simpleMessage(
      "Ne doit pas contenir d’espaces ou de tabulations",
    ),
    "noHousesyet": MessageLookupByLibrary.simpleMessage(
      "Pas encore de maisons",
    ),
    "notAutorise": MessageLookupByLibrary.simpleMessage(
      "🚫 Vous n\'êtes pas autorisé à consulter cette page",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "❌ Les mots de passe ne correspondent pas",
    ),
    "pleaseEnterEmail": MessageLookupByLibrary.simpleMessage(
      "Veuillez entrer votre email",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Veuillez entrer votre mot de passe",
    ),
    "register": MessageLookupByLibrary.simpleMessage("S’inscrire"),
    "registeredAs": m1,
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "❌ Une erreur est survenue",
    ),
    "student": MessageLookupByLibrary.simpleMessage("Étudiant"),
    "yourEmail": MessageLookupByLibrary.simpleMessage("Votre email"),
    "yourHouses": MessageLookupByLibrary.simpleMessage("Vos maisons"),
    "yourPassword": MessageLookupByLibrary.simpleMessage("Votre mot de passe"),
  };
}
