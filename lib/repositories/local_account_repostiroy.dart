import 'dart:convert';

import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAccountRepository extends AccountRepository {
  SharedPreferences prefs;

  LocalAccountRepository(this.prefs);

  @override
  Account getAccount() {
    if (prefs.containsKey("account")) {
      String? serialized = prefs.getString("account");
      if (serialized != null) {
        try {
          print(serialized);
          Account acc = Account.fromMap(jsonDecode(serialized));
          return acc;
        } catch (err, stack) {
          print("Error while deserializing: " + err.toString());
          print(stack);
        }
      }
    }
    // ! Warning: fall-through
    Account acc = Account();
    acc.categories = {
      'Bevétel': ["Fizetés", "Egyszeri bevétel", "Ajándék"],
      'Közüzem': ["Áram", "Víz", "Csatornázás", "Gáz", "Tüzelő"],
      'Autó': ["Javítás", "Tankolás"],
      'Gyerek': ["Tankönyv", "Ebéd befizetés", "Zongora"],
      'Általános': ["Bevásárlás", "Étterem"],
      'Program': ["Mozi", "Színház", "Egyéb"],
    };
    saveAccount(acc);
    return acc;
  }

  @override
  void saveAccount(Account account) {
    String serialized = jsonEncode(account.toMap());
    prefs.setString("account", serialized);
  }

  @override
  void removeAccount() {
    prefs.remove("account");
  }
}
