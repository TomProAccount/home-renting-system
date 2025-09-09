// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Your Email`
  String get yourEmail {
    return Intl.message('Your Email', name: 'yourEmail', desc: '', args: []);
  }

  /// `Your Password`
  String get yourPassword {
    return Intl.message(
      'Your Password',
      name: 'yourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get enterValidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 8 characters`
  String get min8Chars {
    return Intl.message(
      'Must be at least 8 characters',
      name: 'min8Chars',
      desc: '',
      args: [],
    );
  }

  /// `Must contain at least one uppercase letter`
  String get mustContainUppercase {
    return Intl.message(
      'Must contain at least one uppercase letter',
      name: 'mustContainUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Must contain at least one number`
  String get mustContainNumber {
    return Intl.message(
      'Must contain at least one number',
      name: 'mustContainNumber',
      desc: '',
      args: [],
    );
  }

  /// `Must contain at least one special character`
  String get mustContainSpecialChar {
    return Intl.message(
      'Must contain at least one special character',
      name: 'mustContainSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `Must not contain spaces or tabs`
  String get mustNotContainSpaces {
    return Intl.message(
      'Must not contain spaces or tabs',
      name: 'mustNotContainSpaces',
      desc: '',
      args: [],
    );
  }

  /// `❌ Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      '❌ Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `❌`
  String get loginError {
    return Intl.message('❌', name: 'loginError', desc: '', args: []);
  }

  /// `✅ Logged in as {role}`
  String loggedInAs(Object role) {
    return Intl.message(
      '✅ Logged in as $role',
      name: 'loggedInAs',
      desc: '',
      args: [role],
    );
  }

  /// `Confirm Your Password`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm Your Password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get student {
    return Intl.message('Student', name: 'student', desc: '', args: []);
  }

  /// `Landlord`
  String get landlord {
    return Intl.message('Landlord', name: 'landlord', desc: '', args: []);
  }

  /// `❌ Passwords don’t match`
  String get passwordsDoNotMatch {
    return Intl.message(
      '❌ Passwords don’t match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password again`
  String get enterConfirmPassword {
    return Intl.message(
      'Enter your password again',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `✅ Registered as {role}`
  String registeredAs(Object role) {
    return Intl.message(
      '✅ Registered as $role',
      name: 'registeredAs',
      desc: '',
      args: [role],
    );
  }

  /// `Go to Login`
  String get goToLogin {
    return Intl.message('Go to Login', name: 'goToLogin', desc: '', args: []);
  }

  /// `Go to Register`
  String get goToRegister {
    return Intl.message(
      'Go to Register',
      name: 'goToRegister',
      desc: '',
      args: [],
    );
  }

  /// `🚫 You are not authorized to view this page`
  String get notAutorise {
    return Intl.message(
      '🚫 You are not authorized to view this page',
      name: 'notAutorise',
      desc: '',
      args: [],
    );
  }

  /// `Your Houses`
  String get yourHouses {
    return Intl.message('Your Houses', name: 'yourHouses', desc: '', args: []);
  }

  /// `No houses yet`
  String get noHousesyet {
    return Intl.message(
      'No houses yet',
      name: 'noHousesyet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
