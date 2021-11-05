import 'package:duszamobile2021/resources/balance.dart';
import 'package:uuid/uuid.dart';

class Item {
  String id;
  String title;
  DateTime creation;
  String balanceId;
  double amount;
  bool monthly;
  DateTime? endDate;

  Item({
    required this.title,
    required this.creation,
    required this.amount,
    this.monthly = false,
    required Balance balance,
  })  : id = (const Uuid()).v4(),
        balanceId = balance.id;
}
