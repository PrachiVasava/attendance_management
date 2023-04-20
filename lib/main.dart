import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hrms/classes/auth_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrms/constant/language_constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies(){
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Lexend"
      ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
      home: AnimatedSplashScreen(
    splash: 'assets/images/logo.png',
    nextScreen: const auth_page(),
    splashIconSize: 200,
    backgroundColor: Colors.white,
    splashTransition: SplashTransition.fadeTransition,)
      // KeyboardVisibilityProvider(child: LoginScreen()),
    );
  }
}


