import 'package:uuid/uuid.dart';

enum BalanceType { cash, debit, credit }

BalanceType fromValue(String value) {
  switch (value) {
    case "CASH":
      return BalanceType.cash;
    case "DEBIT":
      return BalanceType.debit;
    case "CREDIT":
      return BalanceType.credit;
    default:
      return BalanceType.cash;
  }
}

extension Export on BalanceType {
  String get value {
    switch (this) {
      case BalanceType.cash:
        return "CASH";
      case BalanceType.debit:
        return "DEBIT";
      case BalanceType.credit:
        return "CREDIT";
      default:
        return "ERROR";
    }
  }
}

class Balance {
  String id;

  BalanceType type;
  String name;

  int? dayOfMonth;
  double? limit;

  Balance(this.type, this.name) : id = (const Uuid()).v4();

  Balance.credit(this.name, this.dayOfMonth, this.limit)
      : id = (const Uuid()).v4(),
        type = BalanceType.credit;

  Balance.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        type = fromValue(map['type']),
        name = map['name'],
        dayOfMonth = map['dayOfMonth'],
        limit = map['limit'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.value,
      'name': name,
      'dayOfMonth': dayOfMonth,
      'limit': limit
    };
  }
}
