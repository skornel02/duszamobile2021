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

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
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

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
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

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Print statistics`
  String get printStatistics {
    return Intl.message(
      'Print statistics',
      name: 'printStatistics',
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

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
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

  /// `Finish`
  String get finishButton {
    return Intl.message(
      'Finish',
      name: 'finishButton',
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

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `Easy`
  String get easy {
    return Intl.message(
      'Easy',
      name: 'easy',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Debit`
  String get debit {
    return Intl.message(
      'Debit',
      name: 'debit',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Limit`
  String get limit {
    return Intl.message(
      'Limit',
      name: 'limit',
      desc: '',
      args: [],
    );
  }

  /// `Billing day`
  String get billingDay {
    return Intl.message(
      'Billing day',
      name: 'billingDay',
      desc: '',
      args: [],
    );
  }

  /// `Value can't be null`
  String get cantBeNull {
    return Intl.message(
      'Value can\'t be null',
      name: 'cantBeNull',
      desc: '',
      args: [],
    );
  }

  /// `Value must be positive`
  String get cantBeNegative {
    return Intl.message(
      'Value must be positive',
      name: 'cantBeNegative',
      desc: '',
      args: [],
    );
  }

  /// `Value must be a whole number`
  String get mustBeWhole {
    return Intl.message(
      'Value must be a whole number',
      name: 'mustBeWhole',
      desc: '',
      args: [],
    );
  }

  /// `The day can't be bigger than 31`
  String get cantBeOver31 {
    return Intl.message(
      'The day can\'t be bigger than 31',
      name: 'cantBeOver31',
      desc: '',
      args: [],
    );
  }

  /// `You cannot do that without having a balance first!`
  String get cantWithoutBalance {
    return Intl.message(
      'You cannot do that without having a balance first!',
      name: 'cantWithoutBalance',
      desc: '',
      args: [],
    );
  }

  /// `Balance created successfully!`
  String get balanceCreated {
    return Intl.message(
      'Balance created successfully!',
      name: 'balanceCreated',
      desc: '',
      args: [],
    );
  }

  /// `Spending limit`
  String get spendingLimit {
    return Intl.message(
      'Spending limit',
      name: 'spendingLimit',
      desc: '',
      args: [],
    );
  }

  /// `Item created successfully!`
  String get itemCreated {
    return Intl.message(
      'Item created successfully!',
      name: 'itemCreated',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Spending`
  String get outcome {
    return Intl.message(
      'Spending',
      name: 'outcome',
      desc: '',
      args: [],
    );
  }

  /// `date category`
  String get dateCategory {
    return Intl.message(
      'date category',
      name: 'dateCategory',
      desc: '',
      args: [],
    );
  }

  /// `Specify amount`
  String get specifyAmount {
    return Intl.message(
      'Specify amount',
      name: 'specifyAmount',
      desc: '',
      args: [],
    );
  }

  /// `Add name here`
  String get addNameHere {
    return Intl.message(
      'Add name here',
      name: 'addNameHere',
      desc: '',
      args: [],
    );
  }

  /// `Choose category`
  String get chooseCategory {
    return Intl.message(
      'Choose category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Choose date`
  String get chooseDate {
    return Intl.message(
      'Choose date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Single`
  String get single {
    return Intl.message(
      'Single',
      name: 'single',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Please select a balance!`
  String get selectBalance {
    return Intl.message(
      'Please select a balance!',
      name: 'selectBalance',
      desc: '',
      args: [],
    );
  }

  /// `Accountwide balance`
  String get accountwideBalance {
    return Intl.message(
      'Accountwide balance',
      name: 'accountwideBalance',
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

  /// `Latest transactions`
  String get latestTransactions {
    return Intl.message(
      'Latest transactions',
      name: 'latestTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Credit due dates`
  String get creditCards {
    return Intl.message(
      'Credit due dates',
      name: 'creditCards',
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

  /// `Export data`
  String get exportData {
    return Intl.message(
      'Export data',
      name: 'exportData',
      desc: '',
      args: [],
    );
  }

  /// `Export visuals`
  String get exportVisuals {
    return Intl.message(
      'Export visuals',
      name: 'exportVisuals',
      desc: '',
      args: [],
    );
  }

  /// `With this much money this number of trees could have been planted in the Amazonian rainforest: `
  String get amazonTrees {
    return Intl.message(
      'With this much money this number of trees could have been planted in the Amazonian rainforest: ',
      name: 'amazonTrees',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Account history`
  String get accountMoneyHistory {
    return Intl.message(
      'Account history',
      name: 'accountMoneyHistory',
      desc: '',
      args: [],
    );
  }

  /// `days remaining`
  String get daysRemaining {
    return Intl.message(
      'days remaining',
      name: 'daysRemaining',
      desc: '',
      args: [],
    );
  }

  /// `Over budget`
  String get overBudget {
    return Intl.message(
      'Over budget',
      name: 'overBudget',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Spendings this month`
  String get spendingsThisMonth {
    return Intl.message(
      'Spendings this month',
      name: 'spendingsThisMonth',
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
