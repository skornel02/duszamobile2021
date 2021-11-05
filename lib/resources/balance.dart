import 'package:uuid/uuid.dart';

enum BalanceType { cash, debit, credit }

class Balance {
  String id;

  BalanceType type;
  String name;

  Balance(this.type, this.name) : id = (const Uuid()).v4();
}

class CreditBalance extends Balance {
  int dayOfMonth;
  double limit;

  CreditBalance(String name, {required this.dayOfMonth, this.limit = 0})
      : super(BalanceType.credit, name);
}
