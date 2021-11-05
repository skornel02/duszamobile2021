import 'package:duszamobile2021/enums/money_type.dart';
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionListItem extends StatelessWidget {

  String firm;
  DateTime date;
  String account;
  double amount;
  MoneyType moneyType;

  TransactionListItem(this.firm, this.date, this.account, this.amount, this.moneyType);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(child: Column(
            children: [
              Text(firm),
              Text("${date.toString()} - ${account}")
            ],
          ),),
          Row(
            children: [
              Text("$amount HUF"),
              const FaIcon(FontAwesomeIcons.home)

            ],
          ),
        ],
      ),
    );
  }
}
