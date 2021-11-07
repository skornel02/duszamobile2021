import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';

class ExportItem {
  String itemName;
  String category;
  String subcategory;
  String creation;
  String balanceName;
  double amount;
  String recurrence;
  String? endDate;

  ExportItem.from(Item item, Balance balance)
      : itemName = item.title,
        category = item.category.split("/")[0],
        subcategory = item.category.split("/")[1],
        creation = item.creation.toIso8601String(),
        balanceName = balance.name,
        amount = item.amount,
        recurrence = item.monthly ? "MONTHLY" : "SINGULAR",
        endDate = item.endDate != null ? item.endDate!.toIso8601String() : null;

  static String get headerLine {
    return "Item name;Category;Subcategory;Creation date;Balance name;Amount;Recurrence type;End date";
  }

  String get line {
    return "$itemName;$category;$subcategory;$creation;$balanceName;$amount;$recurrence;${endDate ?? "-"}";
  }
}

List<ExportItem> createExportItems(Account account) {
  List<ExportItem> items = [];
  Balance backup = Balance(BalanceType.cash, "-");
  account.items.forEach((item) {
    Balance balance = account.balances.firstWhere(
        (element) => element.id == item.balanceId,
        orElse: () => backup);
    items.add(ExportItem.from(item, balance));
  });
  return items;
}
