import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


const String LanguageCode = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String HINDI = 'hi';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  Intl.getCurrentLocale();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LanguageCode) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case HINDI:
      return const Locale(HINDI, "");
    default:
      return const Locale(ENGLISH, '');
  }
}



AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}


