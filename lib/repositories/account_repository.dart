import 'package:duszamobile2021/resources/account.dart';
import 'package:flutter/cupertino.dart';

abstract class AccountRepository extends ChangeNotifier {
  /// Returns the users account.
  /// If no account is found generate a new one.
  Account getAccount();
  void saveAccount(Account account);
  void removeAccount();
}
