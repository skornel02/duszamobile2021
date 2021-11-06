import 'package:duszamobile2021/resources/item.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
          "${item.title} - ${item.amount} (${item.creation.toIso8601String()})"),
    );
  }
}
