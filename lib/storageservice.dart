import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'utils/configs.dart';

class StorageService {
  // Save data to local storage
  static Future<void> saveDataToLocal({
    required String accountName,
    required String email,
    required String password,
    required String notes,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(accountNameKey, accountName);
    prefs.setString(emailKey, email);
    prefs.setString(passwordKey, password);
    prefs.setString(notesKey, notes);
  }

  // Load data from local storage
  static Future<Map<String, String>> loadDataFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'accountName': prefs.getString(accountNameKey) ?? '',
      'email': prefs.getString(emailKey) ?? '',
      'password': prefs.getString(passwordKey) ?? '',
      'notes': prefs.getString(notesKey) ?? '',
    };
  }

  // Save entries to local storage
  static Future<void> saveEntriesToLocal(
      List<Map<String, String>> entries) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      entriesKey,
      entries.map((entry) => json.encode(entry)).toList(),
    );
  }

  // Load entries from local storage
  static Future<List<Map<String, String>>> loadEntriesFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? entriesStringList = prefs.getStringList(entriesKey);
    if (entriesStringList == null) {
      return [];
    }

    List<Map<String, String>> entries = [];

    for (String entryString in entriesStringList) {
      print("Entry String: $entryString");

      try {
        Map<String, String> decodedEntry =
            Map<String, String>.from(json.decode(entryString));
        entries.add(decodedEntry);
      } catch (e) {
        print("Error decoding entry: $e");
      }
    }

    return entries;
  }
}
