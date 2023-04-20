import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @login_page.
  ///
  /// In en, this message translates to:
  /// **'Login Page'**
  String get login_page;

  /// No description provided for @loginbtn.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginbtn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @please_enter_email_address.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Email Address'**
  String get please_enter_email_address;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @please_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Password'**
  String get please_enter_password;

  /// No description provided for @home_page.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get home_page;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @demo.
  ///
  /// In en, this message translates to:
  /// **'Demo@gmail.com'**
  String get demo;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User@gmail.com'**
  String get user;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @item_transaction.
  ///
  /// In en, this message translates to:
  /// **'Item Transaction'**
  String get item_transaction;

  /// No description provided for @qr_code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qr_code;

  /// No description provided for @menu_item.
  ///
  /// In en, this message translates to:
  /// **'Menu Item'**
  String get menu_item;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @do_you_really_want_to_log_out.
  ///
  /// In en, this message translates to:
  /// **'Do you Really want to Log Out?'**
  String get do_you_really_want_to_log_out;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @attendance_page.
  ///
  /// In en, this message translates to:
  /// **'Attendance Page'**
  String get attendance_page;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Attendance Calendar'**
  String get calendar;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @select_any_item.
  ///
  /// In en, this message translates to:
  /// **'Select any Item'**
  String get select_any_item;

  /// No description provided for @from_date.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get from_date;

  /// No description provided for @to_date.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get to_date;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @please_select_any_item.
  ///
  /// In en, this message translates to:
  /// **'Please Select any Item'**
  String get please_select_any_item;

  /// No description provided for @please_select_date.
  ///
  /// In en, this message translates to:
  /// **'Please Select Date'**
  String get please_select_date;

  /// No description provided for @tea.
  ///
  /// In en, this message translates to:
  /// **'Tea'**
  String get tea;

  /// No description provided for @coffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get coffee;

  /// No description provided for @snacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get snacks;

  /// No description provided for @petrol.
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get petrol;

  /// No description provided for @diesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get diesel;

  /// No description provided for @oil.
  ///
  /// In en, this message translates to:
  /// **'Oil'**
  String get oil;

  /// No description provided for @item_list.
  ///
  /// In en, this message translates to:
  /// **'Item List'**
  String get item_list;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @selected_item.
  ///
  /// In en, this message translates to:
  /// **'Select Item'**
  String get selected_item;

  /// No description provided for @valid_email_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email Address'**
  String get valid_email_address;

  /// No description provided for @wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Entered Password is Wrong'**
  String get wrong_password;

  /// No description provided for @beverage.
  ///
  /// In en, this message translates to:
  /// **'Beverage'**
  String get beverage;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @menu_of_the_day.
  ///
  /// In en, this message translates to:
  /// **'Menu of the Day'**
  String get menu_of_the_day;

  /// No description provided for @total_amount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get total_amount;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @today_date.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Date'**
  String get today_date;

  /// No description provided for @scan_qr.
  ///
  /// In en, this message translates to:
  /// **'Scan Qr'**
  String get scan_qr;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @name_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get name_hint;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get email_hint;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get date_of_birth;

  /// No description provided for @required_field.
  ///
  /// In en, this message translates to:
  /// **'Required Field'**
  String get required_field;

  /// No description provided for @submit_info.
  ///
  /// In en, this message translates to:
  /// **'Submit Info'**
  String get submit_info;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'**
  String get about;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
