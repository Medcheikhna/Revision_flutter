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

  /// `User Management`
  String get user_management {
    return Intl.message(
      'User Management',
      name: 'user_management',
      desc: '',
      args: [],
    );
  }

  /// `Name:`
  String get name {
    return Intl.message(
      'Name:',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email:`
  String get email {
    return Intl.message(
      'Email:',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Manage `
  String get manage_user {
    return Intl.message(
      'Manage ',
      name: 'manage_user',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to update or delete this user?`
  String get update_or_delete {
    return Intl.message(
      'Do you want to update or delete this user?',
      name: 'update_or_delete',
      desc: '',
      args: [],
    );
  }

  /// `Updating...`
  String get updating {
    return Intl.message(
      'Updating...',
      name: 'updating',
      desc: '',
      args: [],
    );
  }

  /// `Deleting...`
  String get deleting {
    return Intl.message(
      'Deleting...',
      name: 'deleting',
      desc: '',
      args: [],
    );
  }

  /// `Adding...`
  String get adedding {
    return Intl.message(
      'Adding...',
      name: 'adedding',
      desc: '',
      args: [],
    );
  }

  /// `Operation canceled`
  String get operation_canceled {
    return Intl.message(
      'Operation canceled',
      name: 'operation_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
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

  /// `Error`
  String get Error {
    return Intl.message(
      'Error',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get add_user {
    return Intl.message(
      'Add User',
      name: 'add_user',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong`
  String get Something_wrong {
    return Intl.message(
      'Oops! Something went wrong',
      name: 'Something_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get go_back {
    return Intl.message(
      'Go Back',
      name: 'go_back',
      desc: '',
      args: [],
    );
  }

  /// `User deleted successfully!`
  String get user_update_success {
    return Intl.message(
      'User deleted successfully!',
      name: 'user_update_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete user`
  String get failed_delete_user {
    return Intl.message(
      'Failed to delete user',
      name: 'failed_delete_user',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting user`
  String get error_delete_user {
    return Intl.message(
      'Error deleting user',
      name: 'error_delete_user',
      desc: '',
      args: [],
    );
  }

  /// `User added successfully!`
  String get user_added_successfully {
    return Intl.message(
      'User added successfully!',
      name: 'user_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error adding user:`
  String get error_adding_user {
    return Intl.message(
      'Error adding user:',
      name: 'error_adding_user',
      desc: '',
      args: [],
    );
  }

  /// `User updated successfully!`
  String get user_updated_successfully {
    return Intl.message(
      'User updated successfully!',
      name: 'user_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error updating user`
  String get error_updating_user {
    return Intl.message(
      'Error updating user',
      name: 'error_updating_user',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update user`
  String get failed_update_user {
    return Intl.message(
      'Failed to update user',
      name: 'failed_update_user',
      desc: '',
      args: [],
    );
  }

  /// `Select a language`
  String get choose_language {
    return Intl.message(
      'Select a language',
      name: 'choose_language',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
