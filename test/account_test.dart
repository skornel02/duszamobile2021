import 'dart:convert';

import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';

void main() {
  group("Filtering tests", () {
    test("Simple item test", () {
      Balance balance = Balance(BalanceType.debit, "Test balance");
      DateTime start = DateTime.now();
      DateTime end = Jiffy(start).add(weeks: 1).dateTime;
      Item item1 = Item(
        title: "Correct item",
        category: "TestCategory",
        creation: Jiffy(start).add(days: 1).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item2 = Item(
        title: "Before item",
        category: "TestCategory",
        creation: Jiffy(start).subtract(days: 2).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item3 = Item(
        title: "After item",
        category: "TestCategory",
        creation: Jiffy(start).add(days: 9).dateTime,
        amount: 150,
        balance: balance,
      );
      assert(
          filterItemsForRange([item1, item2, item3], start, end).length == 1);
    });
    test("Recurring item test", () {
      Balance balance = Balance(BalanceType.debit, "Test balance");
      DateTime start = DateTime(2021, 2, 1);
      DateTime end = Jiffy(start).add(months: 1).dateTime;
      Item item1 = Item(
        title: "Correct item, this month",
        category: "TestCategory",
        creation: Jiffy(start).add(days: 2).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item2 = Item(
        title: "Correct item, last month",
        category: "TestCategory",
        creation: Jiffy(start).subtract(months: 1).add(days: 3).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item3 = Item(
        title: "Correct item, long-long-ago",
        category: "TestCategory",
        creation: Jiffy(start).subtract(years: 1).add(days: 5).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item4 = Item(
        title: "Incorrect item, next month",
        category: "TestCategory",
        creation: Jiffy(start).add(months: 1, days: 6).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item5 = Item(
        title: "Incorrect item, already closed",
        category: "TestCategory",
        creation: Jiffy(start).subtract(months: 2).add(days: 3).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      item5.endDate = Jiffy(item5.creation).add(months: 1).dateTime;
      assert(filterItemsForRange([item1, item2, item3, item4], start, end)
              .length ==
          3);
    });
  });
  group("Account tests", () {
    test('Test total', () {
      Account acc = Account();
      Balance balance = Balance(BalanceType.debit, "Test balance");
      Item item1 = Item(
        title: "Item1",
        category: "TestCategory",
        creation: Jiffy().subtract(days: 3).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item2 = Item(
        title: "Item2",
        category: "TestCategory",
        creation: Jiffy().subtract(days: 2).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item3 = Item(
          title: "Item3",
          category: "TestCategory",
          creation: Jiffy().subtract(days: 1).dateTime,
          amount: 150,
          balance: balance,
          monthly: true);
      item3.endDate = Jiffy().add(days: 2, months: 1).dateTime;

      acc.balances.add(balance);
      acc.items.addAll([item1, item2, item3]);

      assert(acc.getRunningBalance(Jiffy().dateTime) == 150 * 3);
      assert(acc.getRunningBalance(Jiffy().add(months: 1).dateTime) == 150 * 4);

      assert(acc.getRunningBalance(Jiffy().add(months: 2).dateTime) == 150 * 4);
    });
    test("Test monthy expenses", () {
      Account acc = Account();
      Balance balance = Balance(BalanceType.debit, "Test balance");
      Item item1 = Item(
        // CORRECT
        title: "Item1",
        category: "TestCategory",
        creation: Jiffy([2021, 02, 01, 12, 3, 5]).dateTime,
        amount: -150,
        balance: balance,
      );
      Item item2 = Item(
        // CORRECT
        title: "Item2",
        category: "TestCategory",
        creation: Jiffy([2021, 02, 02]).dateTime,
        amount: -150,
        balance: balance,
      );
      Item item3 = Item(
        // CORRECT
        title: "Item3",
        category: "TestCategory",
        creation: Jiffy([2021, 02, 20]).dateTime,
        amount: -150,
        balance: balance,
        monthly: true,
      );
      Item item4 = Item(
        // CORRECT
        title: "Item4",
        category: "TestCategory",
        creation: Jiffy([2021, 01, 15]).dateTime,
        amount: -150,
        balance: balance,
        monthly: true,
      );
      Item item5 = Item(
        // INCORRECT
        title: "Item5",
        category: "TestCategory",
        creation: Jiffy([2021, 01, 20]).dateTime,
        amount: -150,
        balance: balance,
        monthly: true,
      );
      item5.endDate = Jiffy([2021, 01, 25]).dateTime;
      Item item6 = Item(
        // INCORRECT
        title: "Item6",
        category: "TestCategory",
        creation: Jiffy([2021, 01, 15]).dateTime,
        amount: -150,
        balance: balance,
      );

      acc.balances.add(balance);
      acc.items.addAll([item1, item2, item3, item4, item5, item6]);

      assert(acc.getSpendingMonth(2021, 02) == -150 * 4);
    });
    test("Test monthy income", () {
      Account acc = Account();
      Balance balance = Balance(BalanceType.debit, "Test balance");
      Item item1 = Item(
        // CORRECT
        title: "Item1",
        category: "TestCategory",
        creation: Jiffy([2021, 02, 01, 12, 3, 5]).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item2 = Item(
        // CORRECT
        title: "Item2",
        category: "TestCategory",
        creation: Jiffy([2021, 02, 02]).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item3 = Item(
        // CORRECT
        title: "Item3",
        category: "TestCategory",
        creation: Jiffy([2021, 02, 20]).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item4 = Item(
        // CORRECT
        title: "Item4",
        category: "TestCategory",
        creation: Jiffy([2021, 01, 15]).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item5 = Item(
        // INCORRECT
        title: "Item5",
        category: "TestCategory",
        creation: Jiffy([2021, 01, 20]).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      item5.endDate = Jiffy([2021, 01, 25]).dateTime;
      Item item6 = Item(
        // INCORRECT
        title: "Item6",
        category: "TestCategory",
        creation: Jiffy([2021, 01, 15]).dateTime,
        amount: 150,
        balance: balance,
      );

      acc.balances.add(balance);
      acc.items.addAll([item1, item2, item3, item4, item5, item6]);

      assert(acc.getIncomeMonth(2021, 02) == 150 * 4);
    });
  });

  group("Serialization test", () {
    test("Complex serialization", () {
      Account account = Account();
      Balance balance = Balance(BalanceType.debit, "Test balance");
      Balance balance2 = Balance.credit("Test credit balance", 21, 15000);
      DateTime start = DateTime(2021, 2, 1);
      DateTime end = Jiffy(start).add(months: 1).dateTime;
      Item item1 = Item(
        title: "e",
        category: "TestCategory",
        creation: Jiffy(start).add(days: 2).dateTime,
        amount: 150,
        balance: balance,
        monthly: false,
      );
      Item item2 = Item(
        title: "d",
        category: "TestCategory",
        creation: Jiffy(start).subtract(months: 1).add(days: 3).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item3 = Item(
        title: "c",
        category: "TestCategory",
        creation: Jiffy(start).subtract(years: 1).add(days: 5).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item4 = Item(
        title: "b",
        category: "TestCategory",
        creation: Jiffy(start).add(months: 1, days: 6).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item5 = Item(
        title: "a",
        category: "TestCategory",
        creation: Jiffy(start).subtract(months: 2).add(days: 3).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      item5.endDate = Jiffy(item5.creation).add(months: 1).dateTime;

      account.balances.addAll([balance, balance2]);
      account.items.addAll([item1, item2, item3, item4, item5]);

      var serialized = account.toMap();
      String json = jsonEncode(serialized);
      print(serialized);
      print(json);
      Account nextAccount = Account.fromMap(serialized);
      assert(nextAccount.id == account.id);
      assert(nextAccount.balances.length == account.balances.length);
      assert(nextAccount.items.length == account.items.length);

      var serialized2 = nextAccount.toMap();
      String json2 = jsonEncode(serialized2);
      print(serialized2);
      print(json2);
      assert(json == json2);
    });
  });
}
