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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Error": MessageLookupByLibrary.simpleMessage("Error"),
        "Something_wrong":
            MessageLookupByLibrary.simpleMessage("Oops! Something went wrong"),
        "add_user": MessageLookupByLibrary.simpleMessage("Add User"),
        "adedding": MessageLookupByLibrary.simpleMessage("Adding..."),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleting": MessageLookupByLibrary.simpleMessage("Deleting..."),
        "email": MessageLookupByLibrary.simpleMessage("Email: {0}"),
        "error_adding_user":
            MessageLookupByLibrary.simpleMessage("Error adding user:"),
        "error_delete_user":
            MessageLookupByLibrary.simpleMessage("Error deleting user"),
        "error_updating_user":
            MessageLookupByLibrary.simpleMessage("Error updating user"),
        "failed_delete_user":
            MessageLookupByLibrary.simpleMessage("Failed to delete user"),
        "failed_update_user":
            MessageLookupByLibrary.simpleMessage("Failed to update user"),
        "go_back": MessageLookupByLibrary.simpleMessage("Go Back"),
        "manage_user": MessageLookupByLibrary.simpleMessage("Manage {0}"),
        "name": MessageLookupByLibrary.simpleMessage("Name: {0}"),
        "operation_canceled":
            MessageLookupByLibrary.simpleMessage("Operation canceled"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "update_or_delete": MessageLookupByLibrary.simpleMessage(
            "Do you want to update or delete this user?"),
        "updating": MessageLookupByLibrary.simpleMessage("Updating..."),
        "user_added_successfully":
            MessageLookupByLibrary.simpleMessage("User added successfully!"),
        "user_management":
            MessageLookupByLibrary.simpleMessage("User Management"),
        "user_update_success":
            MessageLookupByLibrary.simpleMessage("User deleted successfully!"),
        "user_updated_successfully":
            MessageLookupByLibrary.simpleMessage("User updated successfully!")
      };
}
