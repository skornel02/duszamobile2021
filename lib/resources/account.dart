import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:jiffy/jiffy.dart';
import 'package:uuid/uuid.dart';

class Account {
  String id;
  List<Balance> balances;
  List<Item> items;

  Account()
      : id = (const Uuid()).v4(),
        balances = [],
        items = [];

  List<Item> _getItemsInDateRange(DateTime start, DateTime end,
      {Balance? balance}) {
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

  static double _sumItemsUp(List<Item> items, DateTime start, DateTime end) {
    double total = 0;
    items.forEach((item) {
      if (!item.monthly) {
        total += item.amount;
      } else {
        DateTime preciseEnd =
            item.endDate == null || end.isBefore(item.endDate!)
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

  double getRunningBalance(DateTime end, {Balance? balance}) {
    List<Item> items = _getItemsInDateRange(DateTime(1), end, balance: balance);
    return _sumItemsUp(items, DateTime(1), end);
  }

  double getSpendingMonth(int year, int month, {Balance? balance}) {
    DateTime start = DateTime(year, month, 1);
    DateTime end =
        Jiffy(DateTime(year, month + 1, 1)).subtract(seconds: 1).dateTime;
    List<Item> items = _getItemsInDateRange(
      start,
      end,
      balance: balance,
    ).where((element) => element.amount < 0).toList();
    return _sumItemsUp(items, start, end);
  }

  double getIncomeMonth(int year, int month, {Balance? balance}) {
    DateTime start = DateTime(year, month, 1);
    DateTime end =
        Jiffy(DateTime(year, month + 1, 1)).subtract(seconds: 1).dateTime;
    List<Item> items = _getItemsInDateRange(
      start,
      end,
      balance: balance,
    ).where((element) => element.amount > 0).toList();
    return _sumItemsUp(items, start, end);
  }
}
