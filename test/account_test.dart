import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';

void main() {
  group("Account tests", () {
    test('Test total', () {
      Account acc = Account();
      Balance balance = Balance(BalanceType.debit, "Test balance");
      Item item1 = Item(
        title: "Item1",
        creation: Jiffy().subtract(days: 3).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item2 = Item(
        title: "Item2",
        creation: Jiffy().subtract(days: 2).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item3 = Item(
          title: "Item3",
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
        creation: Jiffy([2021, 02, 01, 12, 3, 5]).dateTime,
        amount: -150,
        balance: balance,
      );
      Item item2 = Item(
        // CORRECT
        title: "Item2",
        creation: Jiffy([2021, 02, 02]).dateTime,
        amount: -150,
        balance: balance,
      );
      Item item3 = Item(
        // CORRECT
        title: "Item3",
        creation: Jiffy([2021, 02, 20]).dateTime,
        amount: -150,
        balance: balance,
        monthly: true,
      );
      Item item4 = Item(
        // CORRECT
        title: "Item4",
        creation: Jiffy([2021, 01, 15]).dateTime,
        amount: -150,
        balance: balance,
        monthly: true,
      );
      Item item5 = Item(
        // INCORRECT
        title: "Item5",
        creation: Jiffy([2021, 01, 20]).dateTime,
        amount: -150,
        balance: balance,
        monthly: true,
      );
      item5.endDate = Jiffy([2021, 01, 25]).dateTime;
      Item item6 = Item(
        // INCORRECT
        title: "Item6",
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
        creation: Jiffy([2021, 02, 01, 12, 3, 5]).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item2 = Item(
        // CORRECT
        title: "Item2",
        creation: Jiffy([2021, 02, 02]).dateTime,
        amount: 150,
        balance: balance,
      );
      Item item3 = Item(
        // CORRECT
        title: "Item3",
        creation: Jiffy([2021, 02, 20]).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item4 = Item(
        // CORRECT
        title: "Item4",
        creation: Jiffy([2021, 01, 15]).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      Item item5 = Item(
        // INCORRECT
        title: "Item5",
        creation: Jiffy([2021, 01, 20]).dateTime,
        amount: 150,
        balance: balance,
        monthly: true,
      );
      item5.endDate = Jiffy([2021, 01, 25]).dateTime;
      Item item6 = Item(
        // INCORRECT
        title: "Item6",
        creation: Jiffy([2021, 01, 15]).dateTime,
        amount: 150,
        balance: balance,
      );

      acc.balances.add(balance);
      acc.items.addAll([item1, item2, item3, item4, item5, item6]);

      assert(acc.getIncomeMonth(2021, 02) == 150 * 4);
    });
  });
}
