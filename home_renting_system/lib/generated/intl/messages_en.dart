// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(role) => "✅ Logged in as ${role}";

  static String m1(role) => "✅ Registered as ${role}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm Your Password",
    ),
    "enterConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password again",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email",
    ),
    "goToLogin": MessageLookupByLibrary.simpleMessage("Go to Login"),
    "goToRegister": MessageLookupByLibrary.simpleMessage("Go to Register"),
    "landlord": MessageLookupByLibrary.simpleMessage("Landlord"),
    "loggedInAs": m0,
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginError": MessageLookupByLibrary.simpleMessage("❌"),
    "min8Chars": MessageLookupByLibrary.simpleMessage(
      "Must be at least 8 characters",
    ),
    "mustContainNumber": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one number",
    ),
    "mustContainSpecialChar": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one special character",
    ),
    "mustContainUppercase": MessageLookupByLibrary.simpleMessage(
      "Must contain at least one uppercase letter",
    ),
    "mustNotContainSpaces": MessageLookupByLibrary.simpleMessage(
      "Must not contain spaces or tabs",
    ),
    "noHousesyet": MessageLookupByLibrary.simpleMessage("No houses yet"),
    "notAutorise": MessageLookupByLibrary.simpleMessage(
      "🚫 You are not authorized to view this page",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "❌ Passwords don’t match",
    ),
    "pleaseEnterEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter your password",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registeredAs": m1,
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "❌ Something went wrong",
    ),
    "student": MessageLookupByLibrary.simpleMessage("Student"),
    "yourEmail": MessageLookupByLibrary.simpleMessage("Your Email"),
    "yourHouses": MessageLookupByLibrary.simpleMessage("Your Houses"),
    "yourPassword": MessageLookupByLibrary.simpleMessage("Your Password"),
  };
}
