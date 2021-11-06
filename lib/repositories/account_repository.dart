import 'package:duszamobile2021/resources/account.dart';

abstract class AccountRepository {
  /// Returns the users account.
  /// If no account is found generate a new one.
  Future<Account> getAccount();
  Future<void> saveAccount(Account account);
  Future<void> removeAccount();
}
