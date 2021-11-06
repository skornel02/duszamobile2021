import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:duszamobile2021/extensions.dart';

class TransactionListItem extends StatelessWidget {

  String firm;
  DateTime date;
  String account;
  double amount;
  BalanceType balanceType;

  TransactionListItem(this.firm, this.date, this.account, this.amount, this.balanceType);

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
              Text(amount.huf),
              if(balanceType == BalanceType.cash) const FaIcon(FontAwesomeIcons.moneyBill)
              else if(balanceType == BalanceType.credit) const FaIcon(FontAwesomeIcons.creditCard)
              else const FaIcon(FontAwesomeIcons.creditCard)
            ],
          ),
        ],
      ),
    );
  }
}
