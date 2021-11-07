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

List<String> flattenCategories(Map<String, List<String>> categories) {
  List<String> flat = [];
  categories.forEach((category, value) {
    value.forEach((subCategory) {
      flat.add('${category}/${subCategory}');
    });
  });
  return flat;
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

  Account.copy(Account acc) : this.fromMap(acc.toMap());

  Item? getItemFromId(String itemId) {
    return items.firstWhere((element) => element.id == itemId);
  }

  Balance? getBalanceFromId(String balanceId) {
    return balances.firstWhere((element) => element.id == balanceId);
  }

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

  Map<String, int> getCategoryUsage() {
    Map<String, int> usage = {};
    items.forEach((item) {
      usage.putIfAbsent(item.category, () => 0);
      usage[item.category] = usage[item.category]! + 1;
    });
    return usage;
  }

  List<Balance> get creditBalances {
    return balances
        .where((element) => element.type == BalanceType.credit)
        .toList();
  }

  List<Item> get lastSortedItems {
    List<Item> ordered = List.of(items);
    ordered.sort((a1, a2) => a2.creation.compareTo(a1.creation));
    return ordered;
  }

  Account.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        balances = (map['balances'] as List<dynamic>)
            .map((map) => Balance.fromMap(map))
            .toList(),
        items = (map['items'] as List<dynamic>)
            .map((map) => Item.fromMap(map))
            .toList(),
        categories =
            (map['categories'] as Map<dynamic, dynamic>).map((key, value) {
          String nextKey = key;
          List<String> nextVal = List.from(value as List<dynamic>);
          return MapEntry(nextKey, nextVal);
        });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'balances': balances.map((e) => e.toMap()).toList(),
      'items': items.map((e) => e.toMap()).toList(),
      'categories': categories,
    };
  }
}
