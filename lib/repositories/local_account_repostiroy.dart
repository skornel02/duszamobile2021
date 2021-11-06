import 'dart:convert';

import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAccountRepository extends AccountRepository {
  @override
  Future<Account> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("account")) {
      String? serialized = prefs.getString("account");
      if (serialized != null) {
        try {
          Account acc = Account.fromMap(jsonDecode(serialized));
          return acc;
        } catch (err) {
          print("Error while deserializing: " + err.toString());
        }
      }
    }
    // ! Warning: fall-through
    Account acc = Account();
    saveAccount(acc);
    return acc;
  }

  @override
  Future<void> saveAccount(Account account) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String serialized = jsonEncode(account.toMap());
    prefs.setString("account", serialized);
  }

  @override
  Future<void> removeAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("account");
  }
}
