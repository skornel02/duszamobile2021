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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `GreenGuardian`
  String get appTitle {
    return Intl.message(
      'GreenGuardian',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Flutter Demo Home Page`
  String get homePage {
    return Intl.message(
      'Flutter Demo Home Page',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Cards`
  String get cards {
    return Intl.message(
      'Cards',
      name: 'cards',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Balances`
  String get balances {
    return Intl.message(
      'Balances',
      name: 'balances',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Latest transactions`
  String get latestTransactions {
    return Intl.message(
      'Latest transactions',
      name: 'latestTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `This month`
  String get thisMonth {
    return Intl.message(
      'This month',
      name: 'thisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Receipts`
  String get receipts {
    return Intl.message(
      'Receipts',
      name: 'receipts',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Add new`
  String get addNew {
    return Intl.message(
      'Add new',
      name: 'addNew',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Creation`
  String get creation {
    return Intl.message(
      'Creation',
      name: 'creation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about that?`
  String get areYouSure {
    return Intl.message(
      'Are you sure about that?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get new_title {
    return Intl.message(
      'New',
      name: 'new_title',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButton {
    return Intl.message(
      'Continue',
      name: 'continueButton',
      desc: '',
      args: [],
    );
  }

  /// `Add new category`
  String get addNewCategory {
    return Intl.message(
      'Add new category',
      name: 'addNewCategory',
      desc: '',
      args: [],
    );
  }

  /// `Add new sub category`
  String get addNewSubCategory {
    return Intl.message(
      'Add new sub category',
      name: 'addNewSubCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category name already exists!`
  String get categoryNameAlreadyInUse {
    return Intl.message(
      'Category name already exists!',
      name: 'categoryNameAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Subcategory name already exists!`
  String get subcategoryNameAlreadyInUse {
    return Intl.message(
      'Subcategory name already exists!',
      name: 'subcategoryNameAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Category is in use!`
  String get categoryNameInUse {
    return Intl.message(
      'Category is in use!',
      name: 'categoryNameInUse',
      desc: '',
      args: [],
    );
  }

  /// `Subcategory is in use!`
  String get subcategoryNameInUse {
    return Intl.message(
      'Subcategory is in use!',
      name: 'subcategoryNameInUse',
      desc: '',
      args: [],
    );
  }

  /// `Category created successfully!`
  String get categoryCreated {
    return Intl.message(
      'Category created successfully!',
      name: 'categoryCreated',
      desc: '',
      args: [],
    );
  }

  /// `Subcategory created successfully!`
  String get subcategoryCreated {
    return Intl.message(
      'Subcategory created successfully!',
      name: 'subcategoryCreated',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Turn`
  String get turn {
    return Intl.message(
      'Turn',
      name: 'turn',
      desc: '',
      args: [],
    );
  }

  /// `Removed successfully!`
  String get removeSuccessful {
    return Intl.message(
      'Removed successfully!',
      name: 'removeSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Add new balance!`
  String get addNewBalance {
    return Intl.message(
      'Add new balance!',
      name: 'addNewBalance',
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
      Locale.fromSubtags(languageCode: 'hu'),
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
