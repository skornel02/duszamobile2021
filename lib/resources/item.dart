import 'package:duszamobile2021/resources/balance.dart';
import 'package:uuid/uuid.dart';

class Item {
  String id;
  String title;
  String category;
  DateTime creation;
  String balanceId;
  double amount;
  bool monthly;
  DateTime? endDate;
  List<String> filePaths;

  Item({
    required this.title,
    required this.creation,
    required this.category,
    required this.amount,
    this.monthly = false,
    required Balance balance,
  })  : id = (const Uuid()).v4(),
        balanceId = balance.id,
        filePaths = [];

  Item.copy(Item item) : this.fromMap(item.toMap());

  Item.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        category = map['category'],
        creation = DateTime.fromMillisecondsSinceEpoch(map['creation']),
        balanceId = map['balanceId'],
        amount = map['amount'],
        monthly = map['monthly'],
        filePaths = List.from((map['filePaths'] as List<dynamic>?) ?? []) {
    if (map['endDate'] != null) {
      endDate = DateTime.fromMillisecondsSinceEpoch(map['endDate']);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'creation': creation.millisecondsSinceEpoch,
      'balanceId': balanceId,
      'amount': amount,
      'monthly': monthly,
      'endDate': endDate == null ? null : endDate!.millisecondsSinceEpoch,
      'filePaths': filePaths
    };
  }
}
