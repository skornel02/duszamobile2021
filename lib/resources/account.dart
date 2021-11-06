import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:jiffy/jiffy.dart';
import 'package:uuid/uuid.dart';

List<Item> filterItemsForRange(
  List<Item> items,
  DateTime start,
  DateTime end, {
  Balance? balance,
}) {
  return items
      .where((element) {
        if (!element.monthly) {
          return element.creation.isAfter(start) &&
              element.creation.isBefore(end);
        }
        if (element.creation.isAfter(end)) {
          return false;
        }
        if (element.endDate != null && element.endDate!.isBefore(start)) {
          return false;
        }
        return true;
      })
      .where((element) => balance == null || element.balanceId == balance.id)
      .toList();
}

double calculateTotalForItems(
  List<Item> items,
  DateTime start,
  DateTime end,
) {
  double total = 0;
  items.forEach((item) {
    if (!item.monthly) {
      total += item.amount;
    } else {
      DateTime preciseEnd = item.endDate == null || end.isBefore(item.endDate!)
          ? end
          : item.endDate!;
      DateTime preciseStart =
          item.creation.isAfter(start) ? item.creation : start;
      num months = Jiffy(preciseEnd).diff(Jiffy(preciseStart), Units.MONTH);
      total += item.amount * (1 + months);
    }
  });
  return total;
}

class Account {
  String id;
  List<Balance> balances;
  List<Item> items;
  Map<String, List<String>> categories;

  Account()
      : id = (const Uuid()).v4(),
        balances = [],
        items = [],
        categories = {};

  double getRunningBalance(DateTime end, {Balance? balance}) {
    List<Item> items =
        filterItemsForRange(this.items, DateTime(1), end, balance: balance);
    return calculateTotalForItems(items, DateTime(1), end);
  }

  double getSpendingMonth(int year, int month, {Balance? balance}) {
    DateTime start = DateTime(year, month, 1);
    DateTime end =
        Jiffy(DateTime(year, month + 1, 1)).subtract(seconds: 1).dateTime;
    List<Item> items = filterItemsForRange(
      this.items,
      start,
      end,
      balance: balance,
    ).where((element) => element.amount < 0).toList();
    return calculateTotalForItems(items, start, end);
  }

  double getIncomeMonth(int year, int month, {Balance? balance}) {
    DateTime start = DateTime(year, month, 1);
    DateTime end =
        Jiffy(DateTime(year, month + 1, 1)).subtract(seconds: 1).dateTime;
    List<Item> items = filterItemsForRange(
      this.items,
      start,
      end,
      balance: balance,
    ).where((element) => element.amount > 0).toList();
    return calculateTotalForItems(items, start, end);
  }

  Account.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        balances = (map['balances'] as List<Map<String, dynamic>>)
            .map((map) => Balance.fromMap(map))
            .toList(),
        items = (map['items'] as List<Map<String, dynamic>>)
            .map((map) => Item.fromMap(map))
            .toList(),
        categories = map['categories'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'balances': balances.map((e) => e.toMap()).toList(),
      'items': items.map((e) => e.toMap()).toList(),
      'categories': categories,
    };
  }
}
